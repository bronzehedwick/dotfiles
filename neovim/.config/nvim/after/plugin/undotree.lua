-- Exit if undotree isn't loaded.
if not vim.fn.exists(':UndotreeToggle') then
  return
end

-- Add mapping for undotree.
vim.keymap.set('n', '<F8>', ':UndotreeToggle<CR>', { silent = true })
