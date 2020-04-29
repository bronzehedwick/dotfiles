function la --description "Replace la - all listing - with exa if it exists"
  if test -x /usr/local/bin/exa
    command exa --all $argv
  else
    command ls -AF $argv
  end
end
