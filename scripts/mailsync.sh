#!/bin/sh

# Add the Mail directory if it doesn't already exist.
mkdir -p ~/Mail

# Sync mail from IMAP.
/usr/local/bin/mbsync chris

# Do indexing.
/usr/local/bin/mu index --maildir=~/Mail --lazy-check
