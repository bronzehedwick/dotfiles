#!/usr/bin/env fish

function j,
  if ! test -x /usr/local/bin/fzy
    echo "fzy not installed"
    return 2
  end

  argparse -n 'j,' 'n' -- $argv
  set host (awk '/[Hh]ost / { for (i=2;i<=NF;i++) {print $i} }' ~/.ssh/config | grep -v "\*" | fzy)

  if [ ! $host ]
    return 1
  end

  if [ $_flag_n ]
    commandline "ssh $host"
  else
    echo "Connecting to [$host]"
    ssh $host
  end
end
