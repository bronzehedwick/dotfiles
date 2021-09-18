#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Bail out if the webdav volume isn't mounted.
if [ ! -d /Volumes/webdav.fastmail.com/iam.chrisdeluca.me/files/org ]; then
  exit 1
fi

# Pull the remote webdav org org collection to the local disk.
rsync -a /Volumes/webdav.fastmail.com/iam.chrisdeluca.me/files/org/ ~/org/
