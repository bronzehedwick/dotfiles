function ls --description "Replace ls with exa if it exists"
  if test -x /usr/local/bin/exa
    command exa $argv
  else
    command ls $argv
  end
end
