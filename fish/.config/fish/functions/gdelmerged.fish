# Deletes all branches merged into current branch (excluding master and dev).
function gdelmerged
  git branch --merged | grep -E -v "(^\\*|master|dev)" | xargs git branch -d
end
