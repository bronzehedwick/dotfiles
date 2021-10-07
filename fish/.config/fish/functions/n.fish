function n --description "Pass through for nvr to close FTerm floating term."
  command nvr $argv --remote-wait-silent +'lua require("FTerm").close()'
end
