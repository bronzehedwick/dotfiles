function tree
  if test -x /usr/local/bin/exa
    command exa --tree
  else if test -x /usr/local/bin/tree
    command tree
  else
    echo "Not installed"
  end
end
