#!/bin/sh

/usr/local/bin/mbsync chris > ~/.mbsync.log 2>&1
/usr/local/bin/notmuch new
