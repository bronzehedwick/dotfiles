function jq
  if test -x /usr/local/bin/gojq
    command gojq $argv
  else if test -x /usr/local/bin/jq
    command jq $argv
  else
    echo "Not installed"
  end
end
