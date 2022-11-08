function jq
  if test -x /usr/local/bin/gojq; or test -x /opt/homebrew/bin/gojq
    command gojq $argv
  else if test -x /usr/local/bin/jq; or test -x /opt/homebrew/bin/jq
    command jq $argv
  else
    echo "Not installed"
  end
end
