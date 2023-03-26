-- Add twig pattern files to path to be able to configure below.
-- Enables `gf` on include to jump to that file. Bloom specific.
vim.opt.path = '/Users/chris/Sites/Lullabot/dsga_d8/docroot/themes/custom/ga_bloom/components'

-- Use twig commenting instead of HTML.
vim.opt.commentstring = "{# %s #}"

-- Set pattern for vim to recognize twig includes.
vim.opt.include = "^/s*{%/s*include|^/s*{%/s*embed|^/s*{%/s*extends"

-- Use twiglint linter.
vim.cmd('compiler twiglint')

-- Use emmet.
vim.cmd('packadd emmet-vim')
