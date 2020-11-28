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

if test -z "$NVIM_LISTEN_ADDRESS"
  set EDITOR nvim
  set VISUAL nvim
end

if test -n "$NVIM_LISTEN_ADDRESS"
  if test -x /usr/local/bin/page
    set PAGER /usr/local/bin/page
  end
end

# GPG agent
if test -f "$HOME/.gpg-agent-info"
  . "$HOME/.gpg-agent-info"
  set GPG_AGENT_INFO
  set SSH_AUTH_SOCK
end
set GPG_TTY (tty)

if not functions -q fisher
  set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
  curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
  fish -c fisher
end
