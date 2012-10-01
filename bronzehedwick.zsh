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
function parse_git_branch {
  ref=$(git-symbolic-ref HEAD 2> /dev/null) || return
  echo "("${ref#refs/heads/}")"
}

#Git diff & vim
function git_diff() {
  git diff --no-ext-diff -w "$@" | vim -R -
}

# Personal prompt
export PS1="\u@\h:\W\$(parse_git_branch)$ "

#############
# Shortcuts #
#############

#Clear the terminal
alias c="clear"

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

###############
# SVN         #
############### 

#See the ignore list
alias svnignorelist="svn pg -R svn:ignore ."

#Preview what an update will contain
alias svnupdry="svn merge --dry-run -r BASE:HEAD ."

#######
# Git #
#######

#Yes
alias shit="git"
alias gs="git status"
alias gb="git branch"
alias gc="git commit"
alias gd="git diff"
alias go="git checkout"
alias ga="git add"
alias gti="git"

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

#Map epseak to say for TTS
#alias say="echo \"$1\" | espeak -s 120 2>/dev/null"
