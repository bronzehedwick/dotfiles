#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.

# SHELL {{{

if [ -f /usr/local/bin/bash ]; then
  SHELL="/usr/local/bin/bash"
fi

# }}}

# PATH {{{

PATH="/usr/local/bin:$PATH"

if [ "$(uname)" == "Darwin" ]; then
  export PATH="/usr/local/sbin:$PATH"
fi

if hash cargo 2>/dev/null; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

if hash yarn 2>/dev/null; then
  export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fi

# }}}

# Load other files {{{

# Load alias definitions.
if [ -f "$HOME/.bash_aliases" ]; then
  # shellcheck source=/dev/null
  source "$HOME/.bash_aliases"
fi

# Load sensible configs.
if [ -f "$HOME/.sensible.bash" ]; then
  # shellcheck source=/dev/null
  source "$HOME/.sensible.bash"
fi

# Load machine-specific configs.
if [ -f "$HOME/.$(hostname).bash" ]; then
  # shellcheck source=/dev/null
  source "$HOME/.$(hostname).bash"
fi

if type brew &>/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r "$COMPLETION" ]] && source "$COMPLETION"
    done
  fi
fi

# }}}

# Exports {{{

# Set locale for terminals that don't set a default.
export LANG=en_US.UTF-8

# Use colored ls output.
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Personal prompt
export PS1="\\W$ "

# Todo.txt
export TODOTXT_DEFAULT_ACTION=ls

# Set Vim to the EDITOR environment variable
if [ -z "${NVIM+x}" ]; then
  export EDITOR="ed"
  export VISUAL="nvim --noplugin"
fi

if [ -n "${NVIM+x}" ]; then
  export PS1="\\W» "
fi

# GPG agent
if [ -f "${HOME}/.gpg-agent-info" ]; then
  # shellcheck source=/dev/null
  . "${HOME}/.gpg-agent-info"
  export GPG_AGENT_INFO
  export SSH_AUTH_SOCK
fi
GPG_TTY=$(tty)
export GPG_TTY

if hash rg 2>/dev/null; then
  # Ripgrep needs an environment variable to point to it's config.
  export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"
fi

export NVM_DIR="$HOME/.nvm"
# shellcheck source=/dev/null
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# shellcheck source=/dev/null
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# }}}

# Functions {{{

# Colorize man pages
man() {
  env \
    LESS_TERMCAP_mb=$'\e[01;31m' \
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    man "$@"
  }

# Facts for today
function today {
  calendar -A 0 -f /usr/share/calendar/calendar.birthday
  calendar -A 0 -f /usr/share/calendar/calendar.computer
  calendar -A 0 -f /usr/share/calendar/calendar.history
  calendar -A 0 -f /usr/share/calendar/calendar.music
  calendar -A 0 -f /usr/share/calendar/calendar.lotr
}

# Pushes the current git branch to origin
function gpo {
  git push origin "$(git rev-parse --abbrev-ref HEAD)"
}

# Changes to the git root
function grt {
  cd "$(git rev-parse --show-toplevel || echo '.')" || exit
}

# Deletes all branches merged into current branch (excluding master and dev).
function gdelmerged {
  git branch --merged | grep -E -v "(^\\*|master|dev)" | xargs git branch -d
}

# Get the last workday
function yesterworkday {
  if [[ "1" == "$(date +%u)" ]]
  then
    echo "last friday"
  else
    echo "yesterday"
  fi
}

# Check the last command status.
check_lastcommandfailed() {
  code=$?
  if [ $code != 0 ]; then
    echo -n $'\033[37m exited \033[31m'
    echo -n $code
    echo -n $'\033[37m'
    echo ""
  fi
}

# FZF
# shellcheck source=/dev/null
if hash fd > /dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f'
  # Use fd for path completion.
  _fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
  }

  # Use fd to generate the list for directory completion
  _fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
  }
fi

# }}}

export REVIEW_BASE=main

. "$HOME/.cargo/env"

# vim: set fdm=marker
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
