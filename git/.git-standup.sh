#!/bin/bash

function yesterworkday()
{
  if [[ "1" == "$(\date +%u)" ]]
  then
    echo "last friday"
  else
    echo "yesterday"
  fi
}

git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(green)<%an>%Creset' --abbrev-commit --date=relative --committer='Chris DeLuca' --all --since="$(yesterworkday)"

