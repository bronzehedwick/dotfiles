#!/bin/sh

/usr/local/bin/mbsync chris > ~/.mbsync.log 2>&1
notmuch new
# retag all "new" messages "inbox" and "unread"
notmuch tag +inbox +unread -new -- tag:new
# tag all messages from "me" as sent and remove tags inbox and unread
notmuch tag -new -inbox +sent -- delucac@mskcc.org or contact@chrisdeluca.me or signups@chrisdeluca.me or bronzehedwick@gmail.com or christopher.j.deluca@gmail.com
# tag newsletters, but dont show them in inbox
notmuch tag +lists +unread -inbox -new -- from:notifications@github.com
# tag anything that has unsubscribe in the message body as a flyer
# notmuch tag +flyer -inbox -new +unread message:
