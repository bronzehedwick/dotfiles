# Pushes the current git branch to origin
function gpo
  git push origin (git rev-parse --abbrev-ref HEAD)
end


