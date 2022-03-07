#!/usr/bin/env fish

# PATH

if test -d /usr/local/sbin
  set PATH /usr/local/sbin $PATH
end

if test -x /usr/local/bin/cargo
  set PATH ~/.cargo/bin $PATH
end

if test -x /usr/local/bin/yarn
  set PATH ~/.yarn/bin ~/.config/yarn/global/node_modules/.bin $PATH
end

# Neovim settings

if test -z "$NVIM_LISTEN_ADDRESS"
  set -x EDITOR ed
  set -x VISUAL nvim --noplugin
end

if test -n "$NVIM_LISTEN_ADDRESS"
  set -x MANPAGER "/usr/local/bin/nvr -c 'Man!' -o -"
end

# Git

set -x REVIEW_BASE main

# Fisher plugins

if not functions -q fisher
  set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
  curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
  fish -c fisher
end
set -g fish_user_paths "/usr/local/opt/curl/bin" $fish_user_paths
