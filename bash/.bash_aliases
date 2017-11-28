# ~/.bash_aliases: executed by bash(1) for non-login shells.

######
# LS #
######

alias ll='ls -lhcF'
alias la='ls -AF'
alias lla='ls -AFchl'

########
# grep #
########
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# color grep alias for piping to less
alias cgrep='grep --color=always'
alias less='less -R'

#############
# Shortcuts #
#############

#cd Shortcuts
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias -- -="cd -"

alias t="todo.sh"

#################
# Vim/Vi/Neovim #
#################

alias vi="TERM=tmux-256color nvim -u ~/.vimrc.sparse"
alias nvim="TERM=tmux-256color nvim"

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

#######
# Git #
#######

alias gs="git status"
alias gb="git branch"
alias gc="git commit"
alias gd="git diff"
alias ga="git add"
alias grt='cd $(git rev-parse --show-toplevel || echo '.")"
alias gpu='gpo'

# Removes .orig files after git merge
alias mergeclean='find . -name "*.orig" -delete'

#########
# Other #
#########

#Start text-based star wars
alias starwars="telnet towel.blinkenlights.nl"

# Update and prune homebrew packages
alias bubu='brew update && brew upgrade && brew cleanup'
alias brews='brew list'

#############
# Bookmarks #
#############
export sites="$HOME/Sites"
export downloads="$HOME/Downloads"
export owncloud="$HOME/ownCloud"
export chrisdeluca="$HOME/Sites/chrisdeluca.me"
export gambini="$HOME/Sites/gambini"
export patti="/Users/chris/Sites/patriciahorvath"
