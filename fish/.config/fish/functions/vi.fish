function vi
  if test -x /usr/local/bin/nvi
    command nvi $argv
  else
    command vi $argv
  end
end
