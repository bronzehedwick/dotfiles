function ll --description "Replace ll - long listing alias - with exa if available"
  if test -x /usr/local/bin/exa
    command exa --long --all $argv
  else
    command ls -lhcF $argv
  end
end
