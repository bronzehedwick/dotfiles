function la --description "Replace la - all listing - with exa if it exists"
  command exa --all $argv
else
  command ls -AF $argv
end
