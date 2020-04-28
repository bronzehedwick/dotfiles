# Changes to the git root
function grt
  cd (git rev-parse --show-toplevel || echo '.') || exit
end
