#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Bail out if the webdav volume isn't mounted.
if [ ! -d /Volumes/webdav.fastmail.com/iam.chrisdeluca.me/files/org ]; then
  exit 1
fi

# Push the local org collection to the webdav volume.
rsync -a ~/org/ /Volumes/webdav.fastmail.com/iam.chrisdeluca.me/files/org/
