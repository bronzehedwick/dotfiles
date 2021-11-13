-- Load emmet HTML quickwrite plugin.
vim.cmd('packadd emmet-vim')

-- Add twig pattern files to path to be able to configure below. Enables `gf`
-- on include to jump to that file. MSK specific.
vim.opt.path:append('/Users/delucac/Sites/msk-design-system/src/patterns/')

-- Set pattern for vim to recognize twig includes.
vim.opt.include = "^\\s*{%\\s*include|^\\s*{%\\s*embed|^\\s*{%\\s*extends"

-- Point to design system. MSK specific.
vim.opt.includeexpr = vim.fn.substitute('v:fname', 'mskds', '~/Sites/msk-design-system/src/patterns', '')

-- Use twig commenting instead of HTML.
vim.opt.commentstring="{# %s #}"

-- Use twiglint linter.
vim.cmd('compiler twiglint')
