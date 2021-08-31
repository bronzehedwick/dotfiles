#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Bail out if the webdav volume isn't mounted.
if [ ! -d /Volumes/webdav.fastmail.com/iam.chrisdeluca.me/files ]; then
  exit 1
fi

# Sync the mobileorg file to the local location.
if [ -f /Volumes/webdav.fastmail.com/iam.chrisdeluca.me/files/org/mobileorg.org ]; then
  rsync -a /Volumes/webdav.fastmail.com/iam.chrisdeluca.me/files/org/mobileorg.org ~/org/
fi

# Sync the local org collection to the webdav volume.
rsync -a ~/org /Volumes/webdav.fastmail.com/iam.chrisdeluca.me/files/
