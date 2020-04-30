#!/usr/bin/env fish

function grt --description "Changes to the git root"
  cd (git rev-parse --show-toplevel || echo '.') || exit
end
