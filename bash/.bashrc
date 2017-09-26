# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Use colored ls output.
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Load alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable bash completion
if [ "$(uname)" == "Darwin" ]; then
  # enable bash completion via homebrew.
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
else
  # enable programmable completion features (you don't need to enable
  # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
  # sources /etc/bash.bashrc).
  if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
      . /etc/bash_completion
  fi
fi

# Set Vim to the EDITOR environment variable
export EDITOR=nvim
export PAGER=less

# Personal prompt
export PS1="\W $ "

PATH=$PATH:/usr/local/bin

if [ "$(uname)" == "Darwin" ]; then
  export PATH="/usr/local/sbin:$PATH"
fi

# Add rust to path
export PATH="$HOME/.cargo/bin:$PATH"

# Set go path
export GOPATH="/usr/local/go"

# GPG agent
if [ -f "${HOME}/.gpg-agent-info" ]; then
  . "${HOME}/.gpg-agent-info"
  export GPG_AGENT_INFO
  export SSH_AUTH_SOCK
fi
export GPG_TTY=$(tty)

#############
# Functions #
#############

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

# Bitcoin
function btcer {
  if [ -z "$1" ]; then
    AMOUNT=1
  else
    AMOUNT="$1"
  fi
  wget -qO- "https://www.google.com/finance/converter?a=$AMOUNT&from=BTC&to=USD" |  sed "/res/!d;s/<[^>]*>//g"
}

# Facts for today
function today {
  calendar -A 0 -f /usr/share/calendar/calendar.birthday
  calendar -A 0 -f /usr/share/calendar/calendar.computer
  calendar -A 0 -f /usr/share/calendar/calendar.history
  calendar -A 0 -f /usr/share/calendar/calendar.music
  calendar -A 0 -f /usr/share/calendar/calendar.lotr
}

# Bashmarks
if [ -f "${HOME}/.local/bin/bashmarks.sh" ]; then
  source "${HOME}/.local/bin/bashmarks.sh"
fi
