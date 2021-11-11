local map = require'utilities'.map

-- Mappings for built-in Vim git rebase convenience commands.
map {'n', '<LocalLeader>p', ':Pick<CR>', silent = true}
map {'n', '<LocalLeader>s', ':Squash<CR>', silent = true}
map {'n', '<LocalLeader>e', ':Edit<CR>', silent = true}
map {'n', '<LocalLeader>r', ':Reword<CR>', silent = true}
map {'n', '<LocalLeader>f', ':Fixup<CR>', silent = true}
map {'n', '<LocalLeader>d', ':Drop<CR>', silent = true}
map {'n', '<LocalLeader>S', ':Cycle<CR>', silent = true}
