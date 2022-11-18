#!/usr/bin/env fish

function mail
  if test -x /opt/homebrew/bin/neomutt
    command /opt/homebrew/bin/neomutt $argv
  else if test -x /usr/local/bin/neomutt
    command /usr/local/bin/neomutt $argv
  else
    command /usr/bin/mail $argv
  end
end
