# See → fishshell.com/docs/current/commands.html#complete

###################
# Custom bindings #
###################
bind \cw 'beginning-of-line'

#########################
# Command modifications #
#########################

# set ls colors globally
# use solarized colorscheme
set -Ux LSCOLORS gxfxbEaEBxxEhEhBaDaCaD

# some ls aliases
alias ll "ls -lhcF"
alias la "ls -AF"
alias l "ls -CF"
alias lla "ls -AFchl"

# grep aliases
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# color grep alias for piping to less
alias cgrep="grep --color=always"
alias less="less -R"

# Set Vim to the EDITOR environment variable
set -x EDITOR "nvim"

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
if test -n (which growlnotify)
  alias cct="drush cache-clear theme-registry; and growlnotify -t 'Drush' -m 'Theme cache cleared'"
  alias ccv="drush cache-clear views; and growlnotify -t 'Drush' -m 'View cache cleared'"
  alias cca="drush cache-clear all; and growlnotify -t 'Drush' -m 'All caches cleared'"
else if test -n (which kdialog)
  alias cct="drush cache-clear theme-registry; and kdialog --title 'Drush' --passivepopup 'Theme cache cleared' 3"
  alias ccv="drush cache-clear views; and kdialog --title 'Drush' --passivepopup 'Views cache cleared' 3"
  alias cca="drush cache-clear all; and kdialog --title 'Drush' --passivepopup 'All caches cleared' 5"
else
  alias cct="drush cache-clear theme-registry; and tput bel"
  alias ccv="drush cache-clear views; and tput bel"
  alias cca="drush cache-clear all; and tput bel"
end

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

#Date aliases
alias fdate="\date '+%Y-%m-%d'"
alias ftdate="\date '+%Y-%m-%e-%I-%M'"
alias rdate="\date '+%Y%m%d'"

#######
# Git #
#######
alias g="git"
alias shit="git"
alias gs="git status"
alias gb="git branch"
alias gc="git commit"
alias gd="git diff"
alias ga="git add"
alias gti="git"
alias gmc='git log --pretty=format: --name-only | sort | uniq -c | sort -rg | head -100 | less'
alias gfo='git fetch origin'
alias gpu='git push origin (_git_branch_name)'
alias glu='git pull origin (_git_branch_name)'
alias egi="vim (git rev-parse --show-toplevel)/.gitignore"
alias standup=$HOME/.git-standup.sh
alias gfu='git fetch upstream'
alias gmu='git merge upstream/master'
alias gl 'git pull'
alias grt 'cd (git rev-parse --show-toplevel;or echo ".")'
alias gm 'git merge'

#######
# Vim #
#######

alias vi="vim -u ~/.vimrc.sparse"

##############
# IP Address #
##############

function ext-ip
  curl http://wtfismyip.com/text; echo
end

function int-ip
  /sbin/ifconfig $1 | grep "inet" | grep "192.168" | awk '{print $2}'
end

##################
# Other Programs #
##################

alias dir2unix="find . -type f -exec dos2unix {} {} \;"
alias yui="java -jar /usr/bin/yuicompressor/build/yuicompressor*"
alias mergeclean='find -name \*.orig | xargs rm'
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

############
# The Fuck #
############
function fuck -d 'Correct your previous console command'
    set -l exit_code $status
    set -l eval_script (mktemp 2>/dev/null ; or mktemp -t 'thefuck')
    set -l fucked_up_command $history[1]
    thefuck $fucked_up_command > $eval_script
    . $eval_script
    rm $eval_script
    if test $exit_code -ne 0
        history --delete $fucked_up_command
    end
end

alias logo 'fish ~/Dropbox/fish.sh'
