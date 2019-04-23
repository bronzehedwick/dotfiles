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

# Add TeX to path
export PATH="/Library/TeX/texbin:$PATH"

# Add user python to path
export PATH="$PATH:~/Library/Python/3.7/bin"

# Add mozilla build tools to path.
export PATH="$HOME/.config/mozbuild/arcanist/bin:$HOME/.config/mozbuild/moz-phab:$PATH"

####################
# Load other files #
####################

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

# enable bash completion
# shellcheck source=/usr/local/etc/bash_completion
if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    source "$(brew --prefix)/etc/bash_completion";
fi

###########
# Exports #
###########

# Use colored ls output.
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Set Vim to the EDITOR environment variable
if [ -z "${NVIM_LISTEN_ADDRESS+x}" ]; then
    export EDITOR="nvim"
    export VISUAL="nvim"
fi

# Todo.txt
export TODOTXT_DEFAULT_ACTION=ls

# Personal prompt
export PS1="\\W$ "

# GPG agent
if [ -f "${HOME}/.gpg-agent-info" ]; then
    # shellcheck source=/dev/null
    . "${HOME}/.gpg-agent-info"
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
fi
GPG_TTY=$(tty)
export GPG_TTY

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

if [ -n "${NVIM_LISTEN_ADDRESS+x}" ]; then
    alias sp='nvr -o'
    alias vsp='nvr -O'
    alias tabe='nvr --remote-tab'
    alias nvim='nvr'
    alias vim='nvr'
    alias vi='nvr'
    export PS1="\\W» "
fi

# FZF
# shellcheck source=/dev/null
if command -v fd > /dev/null 2>&1; then
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

# Ripgrep needs an environment variable to point to it's config.
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"

# Todo.txt
export TODOTXT_DEFAULT_ACTION=ls

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
