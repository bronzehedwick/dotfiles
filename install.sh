#!/bin/sh
# Installs dotfiles to home directory

# Find all non-hidden, top-level directories in this folder.
find "$(dirname "$0")" -type d -depth 1 -name "[^.]*" | while read -r program;
do
  # Stow (install/link) all programs.
  stow "$(basename "$program")"
done
