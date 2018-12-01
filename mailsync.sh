#!/bin/sh

# sync mail from IMAP
/usr/local/bin/mbsync chris > /tmp/mbsync.log 2>&1

# do initial tagging
/usr/local/bin/notmuch new

# retag all "new" messages in INBOX as "inbox"
/usr/local/bin/notmuch tag +inbox -new folder:INBOX

# retag all messages in Archive as "archive"
/usr/local/bin/notmuch tag +archive -inbox folder:Archive

# retag all messages in Junk as "spam"
/usr/local/bin/notmuch tag +spam -inbox folder:Junk

# retag all messages in Trash as "deleted"
/usr/local/bin/notmuch tag +deleted -inbox -archive folder:Trash

# tag newsletters, defined as anything with the phrase "unsubscribe"
/usr/local/bin/notmuch tag +lists -inbox -new unsubscribe
