function lla --description "Replace lla - long all listing - with exa if it exists"
  if test -x /usr/local/bin/exa
    command exa --long --all $argv
  else
    command ls -AFchl $argv
  end
end

