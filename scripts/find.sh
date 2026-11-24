
#!/usr/bin/env bash

# Parse command line options
SEARCH_TYPE="name"
while getopts "ep" opt; do
    case $opt in
        e)
            SEARCH_TYPE="email"
            ;;
        p)
            SEARCH_TYPE="phone"
            ;;
        \?)
            echo "Usage: $0 [-e|-p] <query>" >&2
            exit 1
            ;;
    esac
done
shift $((OPTIND-1))

QUERY="$1"

if [ -z "$QUERY" ]; then
    echo "Usage: $0 [-e|-p] <query>" >&2
    exit 1
fi

# Get the directory where this script is located
SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

osascript "$SCRIPTS_DIR/find.applescript" "$SEARCH_TYPE" "$QUERY"
