#!/bin/bash
# ~/.bash_aliases: executed by bash(1) for non-login shells.

# ls {{{

alias ll='ls -lhcF'
alias la='ls -AF'
alias lla='ls -AFchl'

# }}}

# grep {{{

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# color grep alias for piping to less
alias cgrep='grep --color=always'
alias less='less -R'

# }}}

# Shortcuts {{{

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias -- -="cd -"

alias t="todo.sh -ta"

# }}}

# Vi/Vim/Neovim {{{

alias vi="nvi"
alias vimdiff="nvim -d"

if [ -n "${NVIM+x}" ]; then
  alias sp='nvr -o'
  alias vsp='nvr -O'
  alias tabe='nvr --remote-tab'
  alias nvim='nvr'
  alias vim='nvr'
  alias vi='nvr'
fi

# }}}

# Replacement commands with different flags {{{

# Disk usage for humans
alias df='df -h'

# Directory usage for humans
alias du="du -h"

# }}}

# git {{{

alias gs="git status"
alias gb="git branch"
alias gbt="git branch | grep \"\\*\" | cut -d ' ' -f 2"
alias gc="git commit"
alias gd="git diff"
alias ga="git add"
alias grt='cd $(git rev-parse --show-toplevel || echo '.")"
alias gpu='gpo'

# Removes .orig files after git merge
alias mergeclean="git status -s|grep orig|awk -F ' ' '{print $2}'|xargs rm"

# }}}

# Other {{{

#Start text-based star wars
alias starwars="telnet towel.blinkenlights.nl"

# Update and prune homebrew packages
alias bubu='brew update && brew upgrade && brew cleanup'
alias brews='brew list'

# }}}

# Bookmarks {{{

export sites="$HOME/Sites"
export downloads="$HOME/Downloads"
export documents="$HOME/Documents"
export writing="$HOME/Documents/Writing"
export dotfiles="$HOME/.dotfiles"
export chrisdeluca="$HOME/Sites/chrisdeluca.me"
export gwengween="$HOME/Documents/GwenGween"
export dts="/Users/chris/Documents/dts"

# }}}

# vim: set fdm=marker
