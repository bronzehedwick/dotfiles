#!/usr/bin/env fish

function fish_prompt
  if test -e "$NVIM_LISTEN_ADDRESS"
    echo (basename (pwd))"» "
  else
    echo (basename (pwd))"\$ "
  end
end
