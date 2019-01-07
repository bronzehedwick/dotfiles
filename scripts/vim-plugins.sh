#!/bin/bash

# Base plugin directory.
DIR="$HOME/.config/nvim/pack"

# Delete packages removed from the plugins file, but only if the pack directory exists.
if [ -d "$DIR" ]; then
    diff <(find "$DIR" -type d -depth 1 | xargs basename | sort) \
      <(grep -v -e "^#" -e "^$" ./vim-plugins.txt | xargs -I {} basename {} .git | sort) | \
      while IFS= read -r OUTDATED || [ -n "$OUTDATED" ]; do
        echo "$OUTDATED" | awk -F ' ' '{print $2}' | xargs -I {} rm -r "$DIR/"{}
      done
fi

# Create the plugin directory if it doesn't exist.
mkdir -p "$DIR"

# Loop over each line of the plugins file, minus empty lines and comments.
grep -v -e "^#" -e "^$" ./vim-plugins.txt | while IFS= read -r LINE || [ -n "$LINE" ]; do
    # Extract repository name from git url.
    REPO="$(echo "$LINE" | cut -d ':' -f 2- | xargs -I {} basename {} .git)"

    # Clone the repo if it doesn't exist yet, otherwise update it.
    if [ -d "$DIR/$REPO/start/$REPO" ]; then
        echo "Updating $REPO"
        git -C "$DIR/$REPO/start/$REPO" fetch
        git -C "$DIR/$REPO/start/$REPO" log --oneline origin/"$(git rev-parse --abbrev-ref HEAD)"..
        git -C "$DIR/$REPO/start/$REPO" pull origin --quiet
        echo ""
    else
        mkdir -p "$DIR/$REPO/start/$REPO"
        git -C "$DIR/$REPO/start" clone --depth 1 "$LINE"
        echo ""
    fi
done

# Generate helptags.
if [ -n "${NVIM_LISTEN_ADDRESS+x}" ]; then
    nvr +helptags\ ALL +qa
else
    nvim +helptags\ ALL +qa
fi
