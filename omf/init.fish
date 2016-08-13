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

# Set NeoVim to the EDITOR environment variable
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

#######
# GPG #
#######
if not begin
  # Is the agent running already? Does the agent-info file exist, and if so,
  # is there a process with the pid given in the file?
  [ -f ~/.gpg-agent-info ]
  and kill -0 (cut -d : -f 2 ~/.gpg-agent-info) ^/dev/null
end
# no, it is not running. Start it!
gpg-agent --daemon --no-grab --write-env-file ~/.gpg-agent-info >/dev/null ^&1
end
# get the agent info from the info file, and export it so GPG can see it.
set -gx GPG_AGENT_INFO (cut -c 16- ~/.gpg-agent-info)
set -gx GPG_TTY (tty)

#######################
# Directory shortcuts #
#######################

# Load fishmarks (http://github.com/techwizrd/fishmarks)
. ~/.fishmarks/marks.fish

##################
# User functions #
##################

# Update and prune homebrew packages
alias bubu 'brew update; and brew upgrade --all; and brew cleanup'

# Bitcoin
function btcer -d 'Get current bitcoin exchange rate'
  if test -z $argv
    set AMOUNT 1
  else
    set AMOUNT $argv
  end

  wget -qO- "https://www.google.com/finance/converter?a=$AMOUNT&from=BTC&to=USD" |  sed "/res/!d;s/<[^>]*>//g"
end

#Start text-based star wars
alias starwars="telnet towel.blinkenlights.nl"

# Facts for today
function today -d 'Display historical events that happened on this date'
  calendar -A 0 -f /usr/share/calendar/calendar.birthday
  calendar -A 0 -f /usr/share/calendar/calendar.computer
  calendar -A 0 -f /usr/share/calendar/calendar.history
  calendar -A 0 -f /usr/share/calendar/calendar.music
  calendar -A 0 -f /usr/share/calendar/calendar.lotr
end

# Helper function for simple python server
function server -d 'Serve the current directory using python'
  python -m SimpleHTTPServer $argv; and open http://localhost:$argv;
end

# Create morning pages file
function mp -d 'Create a morning page file'
  nvim ~/Dropbox/Writing/Morning\ Pages/(date "+%m-%d-%Y").txt +Timestamp
end
