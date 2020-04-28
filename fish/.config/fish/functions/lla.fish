function lla --description "Replace lla - long all listing - with exa if it exists"
  command exa --long --all $argv
else
  command ls -AFchl $argv
end

