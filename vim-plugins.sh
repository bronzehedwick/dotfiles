#!/bin/sh

# Base plugin directory.
DIR="$HOME/.config/nvim/pack/"

# Make sure the plugin directory exists.
mkdir -p "$DIR"

# Loop over each line of the plugins file, minus empty lines and comments.
grep -v -e "^#" -e "^$" ./vim-plugins.txt | while IFS= read -r LINE || [ -n "$LINE" ]
do
    # Extract repository name from git url.
    REPO="$(echo "$LINE" | cut -d ':' -f 2- | xargs -I {} basename {} .git)"

    # Clone the repo if it doesn't exist yet, otherwise update it.
    if [ -d "$DIR/$REPO/start/$REPO" ]; then
        git -C "$DIR/$REPO/start/$REPO" pull origin >/dev/null 2>&1 &
    else
        mkdir -p "$DIR/$REPO/start/$REPO"
        git -C "$DIR/$REPO/start" clone --depth 1 "$LINE" >/dev/null 2>&1 &
    fi
done

# Generate helptags.
if [ -n "${NVIM_LISTEN_ADDRESS+x}" ]; then
    nvr +helptags\ ALL +qa
else
    nvim +helptags\ ALL +qa
fi
