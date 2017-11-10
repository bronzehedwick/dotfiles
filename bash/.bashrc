# ~/.bashrc: executed by bash(1) for non-login shells.

########
# PATH #
########

PATH="/usr/local/bin:$PATH"

if [ "$(uname)" == "Darwin" ]; then
  export PATH="/usr/local/sbin:$PATH"
fi

# Add rust to path
export PATH="$HOME/.cargo/bin:$PATH"

####################
# Load other files #
####################

# Load profile.
if [ -f "$HOME/.bash_profile" ]; then
  . "$HOME/.bash_profile"
fi

# Load alias definitions.
if [ -f "$HOME/.bash_aliases" ]; then
  . "$HOME/.bash_aliases"
fi

# Load sensible configs.
if [ -f "$HOME/.sensible.bash" ]; then
  . "$HOME/.sensible.bash"
fi

# enable bash completion
if [ "$(uname)" == "Darwin" ]; then
  # enable bash completion via homebrew.
  if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    . "$(brew --prefix)/etc/bash_completion"
  fi
else
  # enable programmable completion features (you don't need to enable
  # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
  # sources /etc/bash.bashrc).
  if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
      . /etc/bash_completion
  fi
fi

###########
# Exports #
###########

# Use colored ls output.
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Set Vim to the EDITOR environment variable
export EDITOR=nvim
export PAGER=less

# Personal prompt
export PS1="\W $ "

# GPG agent
if [ -f "${HOME}/.gpg-agent-info" ]; then
  . "${HOME}/.gpg-agent-info"
  export GPG_AGENT_INFO
  export SSH_AUTH_SOCK
fi
export GPG_TTY=$(tty)

# Set locale for terminals that don't set a default.
export LANG=en_US.UTF-8

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

# Get the last workday
function yesterworkday {
  if [[ "1" == "$(date +%u)" ]]
  then
    echo "last friday"
  else
    echo "yesterday"
  fi
}

#############
# Bookmarks #
#############
export sites="$HOME/Sites"
export downloads="$HOME/Downloads"
export owncloud="$HOME/ownCloud"
export chrisdeluca="$HOME/Sites/chrisdeluca.me"
if [ -f $(brew --prefix)/etc/bash_completion ]; then source $(brew --prefix)/etc/bash_completion; fi
