# ~/.bash_aliases: executed by bash(1) for non-login shells.
# for examples

#############
# Shortcuts #
############# 

#Clear the terminal
alias c="clear"

#Edit .bashrc
alias ebrc="vim ~/.bashrc"

#Edit this file
alias eba="vim ~/.bash_aliases"

#Source .bashrc and .bash_aliases
alias sb="source ~/.bashrc && source ~/.bash_aliases"

#cd Shortcuts
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

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
#alias date="date '+%a, %b %d %l:%M:%S %p'"

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
alias lampp='sudo /opt/lampp/lampp'
