function bat --description "Dynamically set bat theme based on os theme"
  if test (/usr/local/bin/dark-mode status) = "off"
    command bat --theme=OneHalfLight $argv
  else
    command bat --theme=OneHalfDark $argv
  end
end
