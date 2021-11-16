local map = require'utilities'.map

-- Exit if Telescope isn't loaded.
if (not vim.fn.exists(':Telescope')) then
  return
end

map {'n', '<M-/>', '<cmd>Telescope find_files<CR>'}
map {'n', '<M-r>', '<cmd>Telescope live_grep<CR>'}
map {'n', '<M-b>', '<cmd>Telescope buffers<CR>'}
map {'n', '<M-h>', '<cmd>Telescope help_tags<CR>'}
