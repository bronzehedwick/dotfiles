function vim --description "Alias vim to nvim"
  if test -e $NVIM_LISTEN_ADDRESS
    command nvr $argv
  else
    command nvim $argv
  end
end

