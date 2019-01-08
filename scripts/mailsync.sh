#!/bin/sh

# Add the Mail directory if it doesn't already exist.
mkdir -p ~/Mail

# Sync mail from IMAP.
/usr/local/bin/mbsync chris

# Do initial tagging.
/usr/local/bin/notmuch new

# Retag mails according to Maildir format.
notmuch tag --batch <<EOF
    +inbox -- folder:INBOX
    -inbox -new -- not folder:INBOX
    +spam -- folder:Junk
    -spam -- not folder:Junk
    +archive -- folder:Archive
EOF
