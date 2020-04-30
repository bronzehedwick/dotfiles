#!/usr/bin/env fish

function n, --description "Present fuzzy searchable menu for npm scripts"

  if ! test -x /usr/local/bin/jq
    echo "jq not installed"
    return 2
  end

  if ! test -x /usr/local/bin/fzy
    echo "fzy not installed"
    return 2
  end

  argparse -n 'n,' 'n' -- $argv
  set cmd (cat package.json | jq .scripts | awk 'NR>2 {print last} {last=$0}' | fzy)

  if [ ! $cmd ]
    return 1
  end

  npm run (echo $cmd | awk -F '":' '{print $1}' | sed 's/"//g' | sed 's/^[  ]*//')
end
