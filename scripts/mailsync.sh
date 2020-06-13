#!/bin/sh

# Sync mail from IMAP.
/usr/local/bin/mbsync chris

# Do indexing.
/usr/local/bin/mu index --lazy-check
