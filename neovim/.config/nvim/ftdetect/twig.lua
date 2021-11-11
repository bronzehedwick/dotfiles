local create_augroups = require'utilities'.create_augroups
local autocmds = {}

autocmds.twig = {
  {'BufNewFile,BufRead', '*.twig', 'set filetype=htmldjango'},
}

create_augroups(autocmds)
