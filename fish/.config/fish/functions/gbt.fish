#!/usr/bin/env fish

function gbt
  command git branch | grep \"\\*\" | cut -d ' ' -f 2
end
