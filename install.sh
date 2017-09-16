#!/bin/sh
# Installs dotfiles to home directory

# Install VimPlug
if [ ! -d "$HOME/.config/nvim/autoload" ]; then
  curl -fLo "$HOME/.config/nvim/autoload/plug.vim" --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Find all non-hidden, top-level directories in this folder.
find "$(dirname "$0")" -type d -depth 1 -name "[^.]*" | while read -r program;
do
  # Stow (install/link) all programs.
  stow "$(basename "$program")"
done
