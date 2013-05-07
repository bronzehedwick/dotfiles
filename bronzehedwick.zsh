#########################
# Command modifications #
#########################

# some ls aliases
alias ll="ls -lhcF"
alias la="ls -AF"
alias l="ls -CF"
alias lla="ls -AFchl"

# grep aliases
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# color grep alias for piping to less
alias cgrep="grep --color=always"
alias less="less -R"

# Set Vim to the EDITOR environment variable
export EDITOR="vim"
export TERM=xterm-256color

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
if hash growlnotify 2>/dev/null; then
  alias cct="drush cache-clear theme-registry && growlnotify -t 'Drush' -m 'Theme cache cleared'"
  alias cca="drush cache-clear all && growlnotify -t 'Drush' -m 'All caches cleared'"
else
  alias cct="drush cache-clear theme-registry"
  alias cca="drush cache-clear all"
fi

###############
# Replacement #
# Commands w/ #
# Different   #
# Flags       #
###############

#Disk usage for humans
alias df="df -h"

#Directory usage for humans
alias du="du -h"

#More useful date
alias date="date '+%a %b %e %I:%M %p'"
alias fdate="\date '+%Y_%m_%d'"
alias ftdate="\date '+%Y_%m_%e_%I_%M'"

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

alias egi="vim $(git rev-parse --show-toplevel)/.gitignore"

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
identica() {
    curl --basic --user bronzehedwick --data-ascii "status=$1" http://identi.ca/api/statuses/update.xml
}
alias dent="identica"
