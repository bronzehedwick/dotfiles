local create_augroups = require 'utilities'.create_augroups
local autocmds = {}

autocmds.mdx = {
  { 'BufNewFile,BufRead', '*.mdx', 'set filetype=markdown' },
}

create_augroups(autocmds)
