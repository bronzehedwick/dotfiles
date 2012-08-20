# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Adjust path
export PATH="usr/local/bin:/usr/local/sbin:~/bin:$PATH"

# Personal prompt
PS1="\h:\W$ "

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# enable color support of ls and also add handy aliases
#if [ -x /usr/bin/dircolors ]; then
    #test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias ls='ls --color=auto'
    #alias dir='dir -CF --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
#fi

# some more ls aliases
alias ll='ls -lhcF'
alias la='ls -AF'
alias l='ls -CF'
alias lla='ls -AFchl'

#Set Vim to the EDITOR environment variable
export EDITOR='vim'


#256 colors
export TERM=xterm-256color

#Git diff & vim
function git_diff() {
  git diff --no-ext-diff -w "$@" | vim -R -
}

# Git autocompletion
source `brew --prefix git`/etc/bash_completion.d/git-completion.bash

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Zend aliases
alias zs='sudo /usr/local/zend/bin/zendctl.sh restart && sudo /usr/local/zend/bin/zendctl.sh restart-mysql'

# Local directory aliases
alias d6='cd ~/Sites/vintage6/htdocs/sites/'
alias ok='cd ~/Sites/vintage6/htdocs/sites/okmagazine.com/'
alias shape='cd ~/Sites/vintage6/htdocs/sites/shape.com/'
alias fitpreg='cd ~/Sites/vintage6/htdocs/sites/fitpregnancy.com/'
alias flex='cd ~/Sites/wonders/htdocs/sites/flexonline.com/'
alias mensfit='cd ~/Sites/vintage6/htdocs/sites/mensfitness.com/'
alias mf='cd ~/Sites/vintage6/htdocs/sites/mensfitness.com/'
alias flexp='cd ~/Sites/flex-phpbb/flex/'
alias flexps='cd ~/Sites/flex-phpbb/flex/styles/new_flex/'

# vim aliases
alias vi='mvim -v'
alias vim='mvim -v'

# ssh aliases
alias devlogin='ssh cdeluca@209.81.89.183'
alias devscp='scp cdeluca@209.81.89.183'
alias devremote='ssh cdeluca@sip-02.fonswitch.com'

# color grep alias for piping to less
alias cgrep='grep --color=always'
alias less='less -R'

# Mac aliases
alias showh='defaults write com.apple.finder AppleShowAllFiles TRUE && killAll Finder'
alias hideh='defaults write com.apple.finder AppleShowAllFiles FALSE && killAll Finder'
alias xattrd='find . | xargs xattr -d'

# Drush aliases
alias cct='drush cache-clear theme-registry'
alias cca='drush cache-clear all'

# Fun stuff when the terminal loads
today=`\date "+%m/%d"`
grep $today /usr/share/calendar/calendar.music
grep $today /usr/share/calendar/calendar.history
grep $today /usr/share/calendar/calendar.computer
grep $today /usr/share/calendar/calendar.birthday

# cd history
source acd_func.sh
alias back='cd -1'
