#!/usr/bin/env fish

# PATH

if test -d /usr/local/sbin
  set PATH /usr/local/sbin $PATH
end

if test -x /usr/local/bin/cargo
  set PATH ~/.cargo/bin $PATH
end

if test -x /usr/local/bin/yarn
  set PATH ~/.yarn/bin ~/.config/yarn/global/node_modules/.bin $PATH
end

if test -e "$NVIM_LISTEN_ADDRESS+x"
  if test -x /usr/local/bin/page
    set PAGER /usr/local/bin/page
  end
end

# Keybindings

if test -x /usr/local/bin/fzy
  bind \cr 'set hist_cmd (history | fzy) && eval $hist_cmd'
end
