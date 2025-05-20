#!/usr/bin/env fish

function nvim --description "Open Neovim within the same instance, if one is running"
  if test -n "$NVIM"
    command nvim --server "$NVIM" --remote $argv
  else
    command nvim $argv
  end
end
