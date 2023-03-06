-- Add twig pattern files to path to be able to configure below.
-- Enables `gf` on include to jump to that file. MSK specific.
vim.opt.path:append('/Users/delucac/Sites/msk-pattern-garden/packages/twig/src/')

-- Set pattern for vim to recognize twig includes.
vim.opt.include = "^/s*{%/s*include|^/s*{%/s*embed|^/s*{%/s*extends"

-- Remove `@` in include for file path. MSK specific.
vim.opt.includeexpr = vim.fn.substitute('v:fname', 'mskds', '', '')

-- Use twig commenting instead of HTML.
vim.opt.commentstring = "{# %s #}"

-- Use twiglint linter.
vim.cmd('compiler twiglint')

-- Use emmet.
vim.cmd('packadd emmet-vim')

-- Add html runtime.
vim.cmd[[
  runtime! ftplugin/html.vim
  runtime! ftplugin/html_*.vim ftplugin/html/*.vim
]]
