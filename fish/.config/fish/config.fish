#!/usr/bin/env fish

set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
set -q XDG_CACHE_HOME; or set XDG_CACHE_HOME ~/.cache

# Neovim settings

if test -z "$NVIM"
  set -x VISUAL nvim --noplugin
end

# Ripgrep

set -x RIPGREP_CONFIG_PATH $XDG_CONFIG_HOME/ripgrep/ripgreprc

# Git

set -x REVIEW_BASE main

# Fisher plugins

if not functions -q fisher
  curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
  fish -c fisher
end

if test -x "/usr/local/opt/curl/bin"
  set -g fish_user_paths "/usr/local/opt/curl/bin" $fish_user_paths
else if test -x "/opt/homebrew/opt/curl/bin"
  set -g fish_user_paths "/opt/homebrew/opt/curl/bin" $fish_user_paths
end
