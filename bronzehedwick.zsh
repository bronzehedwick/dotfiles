#########################
# Command modifications #
#########################

# some ls aliases
alias ll='ls -lhcF'
alias la='ls -AF'
alias l='ls -CF'
alias lla='ls -AFchl'

# grep aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# color grep alias for piping to less
alias cgrep='grep --color=always'
alias less='less -R'

# Set Vim to the EDITOR environment variable
export EDITOR='vim'

export TERM=xterm-256color

# git prompt
#function parse_git_branch {
  #ref=$(git-symbolic-ref HEAD 2> /dev/null) || return
  #echo "("${ref#refs/heads/}")"
#}

#Git diff & vim
#function git_diff() {
  #git diff --no-ext-diff -w "$@" | vim -R -
#}

# Personal prompt
#export PS1="\u@\h:\W\$(parse_git_branch)$ "

#############
# Shortcuts #
#############

#cd Shortcuts
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Clear the terminal
alias c="clear"

# Drush aliases
alias cct='drush cache-clear theme-registry'
alias cca='drush cache-clear all'


###############
# Replacement #
# Commands w/ #
# Different   #
# Flags       #
###############

#Disk usage for humans
alias df='df -h'

#Directory usage for humans
alias du="du -h"

#More useful date
alias date="date '+%a, %b %d %l:%M:%S %p'"

#######
# Git #
#######

alias shit="git"
alias gs="git status"
alias gb="git branch"
alias gc="git commit"
alias gd="git diff"
alias go="git checkout"
alias ga="git add"
alias gti="git"

egi()
{
    TOP_LEVEL=$(git rev-parse --show-toplevel)
    vim $TOP_LEVEL/.gitignore
}

##################
# Other Programs #
##################

alias dir2unix="find . -type f -exec dos2unix {} {} \;"
alias yui="java -jar /usr/bin/yuicompressor/build/yuicompressor*" 

#############
# Fun Stuff #
#############

#Start text-based star wars
alias starwars="telnet towel.blinkenlights.nl"

#Identica
alias dent="identica"

