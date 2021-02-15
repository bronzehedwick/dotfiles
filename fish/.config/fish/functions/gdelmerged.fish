#!/usr/bin/env fish

function gdelmerged --description "Deletes all branches merged into current branch (excluding main, master, and dev)."
  git branch --merged | grep -E -v "(^\\*|master|main|dev)" | xargs git branch -d
end
