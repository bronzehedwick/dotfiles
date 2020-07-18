function vi --description "Alias vi to nvim"
  if test -e $NVIM_LISTEN_ADDRESS
    command nvr $argv
  else
    command nvim $argv
  end
end

