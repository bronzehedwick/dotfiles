#!/usr/bin/env fish

function e --description "Shortcut for Neovim with options."
  if test -z "$NVIM"
    command nvim --listen "$XDG_CACHE_HOME/nvim/server.pipe" $argv
  else
    command nvim --server "$XDG_CACHE_HOME/nvim/server.pipe" --remote-send "<esc>:edit $argv<cr>"
  end
end
