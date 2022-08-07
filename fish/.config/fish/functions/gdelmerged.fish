#!/usr/bin/env fish

function gdelmerged --description "Deletes all branches merged into current branch (excluding main, master, and dev)."
  git branch --merged | grep -v -e master -e main -e develop | xargs git branch -d
end
