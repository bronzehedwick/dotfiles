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
# Drush       #
############### 
alias cca='drush cache-clear all'
alias cct='drush cache-clear theme-registry'

#######
# Git #
#######

alias g='git'
alias gl="git pull"
alias gs="git status"
alias gb="git branch"
alias gc="git commit"
alias gd="git diff"
alias go="git checkout"
alias ga="git add"
alias gti="git"
gba='git branch -a'
gca='git commit -v -a'
gcl='git config --list'
gclean='git reset --hard && git clean -dfx'
gcm='git checkout master'
gcmsg='git commit -m'
gco='git checkout'
gcount='git shortlog -sn'
gcp='git cherry-pick'
gd='git diff'
gdc='git diff --cached'
gfo='git fetch origin'
gg='git gui citool'
gga='git gui citool --amend'
ggpnp='git pull origin $(current_branch) && git push origin $(current_branch)'
ggpull='git pull origin $(current_branch)'
ggpur='git pull --rebase origin $(current_branch)'
ggpush='git push origin $(current_branch)'
gist='nocorrect gist'
gk='gitk --all --branches'
gl='git pull'
glg='git log --stat --max-count=10'
glgg='git log --graph --max-count=10'
glgga='git log --graph --decorate --all'
glo='git log --oneline'
globurl='noglob urlglobber '
glp=_git_log_prettily
glu='git pull origin $(current_branch)'
gm='git merge'
gmc='git log --pretty=format: --name-only | sort | uniq -c | sort -rg | head -100 | less'
gmt='git mergetool --no-prompt'
go='git checkout'
gp='git push'
gpoat='git push origin --all && git push origin --tags'
gpu='git push origin $(current_branch)'
gr='git remote'
grba='git rebase --abort'
grbc='git rebase --continue'
grbi='git rebase -i'
grep='grep --color=auto'
grh='git reset HEAD'
grhh='git reset HEAD --hard'
grmv='git remote rename'
grrm='git remote remove'
grset='git remote set-url'
grt='cd $(git rev-parse --show-toplevel || echo ".")'
grup='git remote update'
grv='git remote -v'
gs='git status'
gsd='git svn dcommit'
gsr='git svn rebase'
gss='git status -s'
gst='git status'
gsta='git stash'
gstd='git stash drop'
gstp='git stash pop'
gsts='git stash show --text'
gti=git
gunwip='git log -n 1 | grep -q -c wip && git reset HEAD~1'
gup='git pull --rebase'
gwc='git whatchanged -p --abbrev-commit --pretty=medium'
gwip='git add -A; git ls-files --deleted -z | xargs -0 git rm; git commit -m "wip"'
mergeclean='find -name \*.orig | xargs rm'

#########
# Sites #
#########
alias tdm_qa='cd ~/tdm_qa'
alias tdm_qa2='cd ~/tdm_qa2'
alias tdm_qa3='cd ~/tdm_qa3'
alias tdm_qa4='cd ~/tdm_qa4'
alias tdm_qa5='cd ~/tdm_qa5'
alias tdm_qa6='cd ~/tdm_qa6'
alias tat_qa='cd ~/tat_qa'
alias tat_qa2='cd ~/tat_qa2'

# Release
alias release_date='\date '\''+%Y%m%d'\'
alias rdate='\date '\''+%Y%m%d'\'
alias rd='\date '\''+%Y%m%d'\'
alias nighthawk='cd /home/cdeluca/nighthawk'
