#!/usr/bin/env fish

function bubu --description "Update and prune homebrew packages"
  command brew update && brew upgrade && brew cleanup
end
