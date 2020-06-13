#!/bin/sh

# Add the Mail directory if it doesn't already exist.
/usr/local/bin/mu mkdir ~/Mail

# Sync mail from IMAP.
/usr/local/bin/mbsync chris

# Do initial mail indexing.
/usr/local/bin/mu init --maildir ~/Mail --my-address iam@chrisdeluca.me --my-address contact@chrisdeluca.me --my-address code@chrisdeluca.me --my-address christopher.j.deluca@gmail.com --my-address bronzehedwick@gmail.com --my-address signups@chrisdeluca.me

# Initial index.
/usr/local/bin/mu index
