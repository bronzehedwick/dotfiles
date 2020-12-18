function vi --description "Alias vi to nvim"
  if test -n "$NVIM_LISTEN_ADDRESS"
    command nvr $argv
  else
    command nvim $argv
  end
end

