
# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Claude Code skill that provides contact information from macOS Contacts app. It's designed to be used when texting, calling, emailing, or social networking with people and companies. The skill is macOS-specific and requires `osascript` to interact with the Contacts application via AppleScript.

## Architecture

The skill follows a simple shell script wrapper + AppleScript implementation pattern:

- **Shell Script Wrapper** (`scripts/find.sh`): Entry point that accepts a query name argument and invokes the corresponding AppleScript file
- **AppleScript Implementation** (`scripts/find.applescript`): Contains the actual logic to query macOS Contacts app using AppleScript's `tell application "Contacts"` syntax

This architecture allows the skill to be invoked from bash while leveraging macOS's native scripting capabilities to access the Contacts database.

## Key Commands

### Running the skill

```bash
# Find contact by name (use quotes for multi-word names)
./scripts/find.sh Alice
./scripts/find.sh "John Smith"

# Find contact by email address
./scripts/find.sh -e alice@example.com
./scripts/find.sh -e "john@"

# Find contact by phone number
./scripts/find.sh -p 555-1234
./scripts/find.sh -p "(555) 123"
```

### Installation

```bash
# Symlink skill to Claude's skills directory
make install
```

## Implementation Details

### Contact Search
- **By Name (default)**: Uses AppleScript's `every person whose name contains query` for case-insensitive substring matching
- **By Email (`-e` flag)**: Uses AppleScript's `every person whose emails's value contains query` for efficient filtering
- **By Phone (`-p` flag)**: Uses AppleScript's `every person whose phones's value contains query` for efficient filtering
- Returns all matching contacts (not just exact matches)
- Currently extracts: name, phone numbers, and email addresses with labels
- Phone numbers and emails are formatted as `value (label)` (e.g., "(555) 123-4567 (mobile)", "user@example.com (work)")

### Output Format
Plain text format:
```
Name: [Full Name]
Phone: [number] ([label])
Phone: [number] ([label])
Email: [email] ([label])
Email: [email] ([label])

```
(Note: Blank line separates multiple contact records)

## Platform Requirements

- macOS only (relies on macOS Contacts app and osascript)
- No external dependencies beyond standard macOS utilities
