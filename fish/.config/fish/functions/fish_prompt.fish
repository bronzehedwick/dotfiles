#!/usr/bin/env fish

function fish_prompt
  if test $status -gt 0
    set_color red
  else
    set_color normal
  end
  if test -e "$NVIM"
    echo (basename (pwd))"» "(set_color normal)
  else
    echo (basename (pwd))"\$ "(set_color normal)
  end
end
