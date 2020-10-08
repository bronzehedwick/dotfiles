function jq
  if test -x /usr/local/bin/gojq
    command gojq
  else if test -x /usr/local/bin/jq
    command jq
  else
    echo "Not installed"
  end
end
