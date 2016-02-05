########
# Path #
########
set PATH /usr/local/sbin $PATH

###################
# Custom bindings #
###################
bind \cw 'beginning-of-line'

#########################
# Command modifications #
#########################

# some ls aliases
alias ll "ls -lhcF"
alias la "ls -AF"
alias l "ls -CF"
alias lla "ls -AFchl"

# Set Vim to the EDITOR environment variable
set -x EDITOR "nvim"

#############
# Shortcuts #
#############

#cd Shortcuts
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

#######
# Git #
#######
alias g="git"
alias gs="git status"
alias gb="git branch"
alias gc="git commit"
alias gd="git diff"
alias ga="git add"
alias gm 'git merge'
alias gl 'git pull'
alias gpo='git push origin (_git_branch_name)'
alias standup=$HOME/.git-standup.sh
alias gfu='git fetch upstream'
alias gmu='git merge upstream/master'
alias grt 'cd (git rev-parse --show-toplevel;or echo ".")'

##################
# Other Programs #
##################

alias bubu 'brew update; and brew upgrade --all; and brew cleanup'
alias irc 'irssi'

#############
# Fun Stuff #
#############

#Start text-based star wars
alias starwars="telnet towel.blinkenlights.nl"

# Facts for today
function today
  calendar -A 0 -f /usr/share/calendar/calendar.birthday
  calendar -A 0 -f /usr/share/calendar/calendar.computer
  calendar -A 0 -f /usr/share/calendar/calendar.history
  calendar -A 0 -f /usr/share/calendar/calendar.music
  calendar -A 0 -f /usr/share/calendar/calendar.lotr
end

#######################
# Directory shortcuts #
#######################
alias dw 'cd ~/Downloads'
alias sites 'cd ~/Sites'
alias docs 'cd ~/Documents'
alias pics 'cd ~/Pictures'

##################
# User functions #
##################
function server -d 'Serve the current directory using python'
  open http://localhost:$argv; and python -m SimpleHTTPServer $argv
end

function mp -d 'Create a morning page file'
  nvim ~/Dropbox/Writing/Morning\ Pages/(date "+%m-%d-%Y").txt
end
