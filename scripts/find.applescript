
on run argv

    set searchType to item 1 of argv
    set query to item 2 of argv

    tell application "Contacts"
        if searchType is "email" then
            set matchingPeople to every person whose emails's value contains query
        else if searchType is "phone" then
            set matchingPeople to every person whose phones's value contains query
        else
            set matchingPeople to every person whose name contains query
        end if

        set output to ""
        repeat with aPerson in matchingPeople
            set output to output & "Name: " & name of aPerson & linefeed

            -- Get phone numbers
            set phoneList to phones of aPerson
            if (count of phoneList) > 0 then
                repeat with aPhone in phoneList
                    set output to output & "Phone: " & value of aPhone & " (" & label of aPhone & ")" & linefeed
                end repeat
            end if

            -- Get email addresses
            set emailList to emails of aPerson
            if (count of emailList) > 0 then
                repeat with anEmail in emailList
                    set output to output & "Email: " & value of anEmail & " (" & label of anEmail & ")" & linefeed
                end repeat
            end if

            set output to output & linefeed
        end repeat

        return output
    end tell
end run
