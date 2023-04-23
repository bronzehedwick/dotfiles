-- Load emmet HTML quickwrite plugin.
vim.cmd('packadd emmet-vim')

-- Auto complete quotes for HTML attributes.
vim.keymap.set(
  'i',
  '=',
  require('utilities').autocomplete_html_attribute,
  { expr = true, buffer = true }
)
