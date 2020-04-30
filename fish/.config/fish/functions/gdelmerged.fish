#!/usr/bin/env fish

function gdelmerged --description "Deletes all branches merged into current branch (excluding master and dev)."
  git branch --merged | grep -E -v "(^\\*|master|dev)" | xargs git branch -d
end
