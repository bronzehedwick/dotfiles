#!/usr/bin/env fish

function fgb
  command git checkout (git branch | cut -c 3- | fzy)
end

