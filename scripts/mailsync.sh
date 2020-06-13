#!/bin/sh

# Add the Mail directory if it doesn't already exist.
# Make sure Drafts are included.
mkdir -p ~/Mail/Drafts/cur ~/Mail/Drafts/new ~/Mail/Drafts/tmp

# Sync mail from IMAP.
/usr/local/bin/mbsync chris

# Do indexing.
/usr/local/bin/mu index --lazy-check
