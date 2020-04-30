#!/usr/bin/env fish

function gpo --description "Pushes the current git branch to origin"
  git push origin (git rev-parse --abbrev-ref HEAD)
end


