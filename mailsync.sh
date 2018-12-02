#!/bin/sh

# sync mail from IMAP
/usr/local/bin/mbsync chris > /tmp/mbsync.log 2>&1

# do initial tagging
/usr/local/bin/notmuch new

# retag mails according to Maildir format
notmuch tag --batch <<EOF
    +inbox -- folder:INBOX
    -inbox -new -- not folder:INBOX
    +spam -- folder:Junk
    -spam -- not folder:Junk
    +archive -- folder:Archive
EOF
