-- Archetecture detection {{{
local arch = vim.fn.system { 'arch' }

local function brew_path()
    if arch == 'arm64' then
        return '/opt/homebrew/bin'
    else
        return '/usr/local/bin'
    end
end
-- }}}

-- Interface {{{

-- Use soft tabs.
vim.opt.expandtab = true

-- Indent 2 spaces by default.
vim.opt.shiftwidth = 2

-- Spell checking.
vim.o.spell = true

-- Prevents inserting two spaces after punctuation on a join (J).
vim.o.joinspaces = false

-- Case insensitive search when using any capital letters.
vim.o.ignorecase = true
vim.o.smartcase = true

-- Disable mouse, to prevent accidental clicks.
vim.o.mouse = ''

-- Message pager does not fill entire screen.
-- See https://github.com/neovim/neovim/pull/8088
vim.o.fillchars = 'msgsep:◌'

-- TODO Re-enable if LSP server for buffer does not have a formatexpr.
-- Format text (gq) with par if it exists.
-- if vim.fn.executable('par') == 1 then
--   vim.opt.formatprg = 'par'
-- end

-- Make the jump-list behave like the tag list or a web browser.
vim.opt.jumpoptions = 'stack'

-- Use ripgrep as external grep tool, if available.
if vim.fn.executable('rg') == 1 then
    vim.opt.grepprg = 'rg --no-heading --vimgrep'
end

-- Automatically open, but do not go to (if there are errors) the quickfix /
-- location list window, or close it when is has become empty.
--
-- NOTE: Must allow nesting of autocmds to enable any customizations for
-- quickfix buffers.
--
-- NOTE: Normally, :cwindow jumps to the quickfix window if the command opens
-- it (but not if it's already open). However, as part of the autocmd, this
-- doesn't seem to happen.
vim.api.nvim_create_augroup('MakerQuickFix', {})
vim.api.nvim_create_autocmd({ 'QuickFixCmdPost' }, {
    group = 'MakerQuickFix',
    pattern = { '[^l]*' },
    command = 'cwindow',
    nested = true,
})
vim.api.nvim_create_autocmd({ 'QuickFixCmdPost' }, {
    group = 'MakerQuickFix',
    pattern = { 'l*' },
    command = 'lwindow',
    nested = true,
})

-- }}}

-- Display {{{

-- Use 24-bit color.
vim.opt.termguicolors = true

-- Don't redraw while typing macros.
vim.o.lazyredraw = true

-- Update swap file and gitgutter much faster.
vim.o.updatetime = 250

-- Command <Tab> completion.
vim.o.wildmode = 'longest:full'

-- Message popup is slightly transparent.
vim.o.pumblend = 10

-- Higlight invisible whitespace.
vim.o.list = true

-- Set hard wrapping guide.
vim.o.colorcolumn = '80'

-- Highlight the cursor line background.
vim.opt.cursorline = true

-- Diff options.
if vim.fn.has('nvim-0.9') == 1 then
    vim.o.diffopt = 'internal,filler,vertical,algorithm:patience,linematch:60'
else
    vim.o.diffopt = 'internal,filler,vertical,algorithm:patience'
end

-- Show effects of comman incrementally, as you type.
vim.o.inccommand = 'nosplit'

-- Make file messages even shorter and messier.
vim.o.shortmess = 'filnxrtToOF'

-- Puts new vsplit windows to the right of the current.
vim.o.splitright = true

-- Puts new split windows to the bottom of the current.
vim.o.splitbelow = true

vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('highlight_yank', {}),
    desc = 'Hightlight selection on yank',
    pattern = '*',
    callback = function()
        vim.highlight.on_yank { higroup = 'IncSearch', timeout = 300 }
    end,
})

-- Use relative line numbers. Useful for jumping.
vim.opt.relativenumber = false

-- Set timeout to lower than default. Useful for which key, plus I don't need to wait.
vim.opt.timeoutlen = 500

-- }}}

-- Buffers {{{

-- Allow switching buffers without saving.
vim.o.hidden = true

-- Allow undo
vim.o.undofile = true

-- Enable syntax highlighting for JSDoc.
vim.g.javascript_plugin_jsdoc = 1

-- Disable netrw, since I'm using Dirvish instead.
vim.g.loaded_netrwPlugin = 0

-- }}}

-- Statusline {{{

-- Tail of file (just the name.ext).
vim.opt.statusline = '%< %t'
-- File modified flag.
vim.opt.statusline:append('%m')
-- Buffer has help flag.
vim.opt.statusline:append('%< %h')
-- Buffer has preview flag.
vim.opt.statusline:append('%< %w')
-- New group.
vim.opt.statusline:append('%=')
-- Percentage through the file.
vim.opt.statusline:append('%p%%')
-- New group.
vim.opt.statusline:append('%=')
-- Line number.
vim.opt.statusline:append('%l')

-- }}}

-- Terminal {{{

if vim.fn.executable(brew_path() .. '/fish') then
    vim.o.shell = brew_path() .. '/fish'
end

-- Set the status line to the process name set by the terminal.
vim.api.nvim_create_autocmd('TermOpen', {
    pattern = { '*' },
    command = [[setlocal statusline=%{b:term_title} nonumber norelativenumber nospell]]
})

-- }}}

-- Plugins {{{1

vim.g.undotree_SetFocusWhenToggle = true

-- Gitsigns {{{2
require('gitsigns').setup {
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end
        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { expr = true })
        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true })
        -- Actions
        map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
        map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
        map('n', '<leader>hS', gs.stage_buffer)
        map('n', '<leader>hu', gs.undo_stage_hunk)
        map('n', '<leader>hp', gs.preview_hunk)
        map('n', '<leader>hb', function() gs.blame_line { full = true } end)
        map('n', '<leader>tb', gs.toggle_current_line_blame)
        map('n', '<leader>hd', gs.diffthis)
        map('n', '<leader>hD', function() gs.diffthis('~') end)
        map('n', '<leader>td', gs.toggle_deleted)
        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
}
-- }}}

-- Diffview {{{2
require('diffview').setup({
    use_icons = false,
})
-- }}}

-- Emmet {{{2

-- Add responsive meta tag to html5 emmet snippet.
local emmet_opts = {
    variables = { lang = 'en-US' },
    html = {
        default_attributes = {
            option = { value = nil },
            textarea = { id = nil, name = nil, cols = 10, rows = 10 },
        },
        snippets = {},
    },
}
emmet_opts.html.snippets['html:5'] = [[
<!DOCTYPE html>
<html lang="${lang}">
  <head>
      <meta charset="${charset}">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title></title>
  </head>
  <body>
      ${child}|
  </body>
</html>]]
vim.g.user_emmet_settings = emmet_opts

-- }}}

-- Treesitter {{{2

require 'nvim-treesitter.configs'.setup {
    -- one of "all", "maintained" (parsers with maintainers), or a list of
    -- languages
    ensure_installed = {
        'awk',
        'bash',
        'c',
        'comment',
        'css',
        'diff',
        'dockerfile',
        'fish',
        'git_config',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'hjson',
        'html',
        'htmldjango',
        'http',
        'javascript',
        'jsdoc',
        'json',
        'json5',
        'jsonc',
        'latex',
        'lua',
        'make',
        'markdown',
        'markdown_inline',
        'mermaid',
        'org',
        'php',
        'phpdoc',
        'python',
        'regex',
        'rst',
        'rust',
        'scss',
        'sql',
        'ssh_config',
        'toml',
        'tsx',
        'twig',
        'typescript',
        'vim',
        'vimdoc',
        'yaml',
    },
    highlight = {
        enable = true, -- false will disable the whole extension
        additional_vim_regex_highlighting = { 'org', 'markdown', 'ssh_config' }
    },
    indent = {
        enable = true
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 'gnn',
            node_incremental = 'gnr',
            scope_incremental = 'gnc',
            node_decremental = 'gnm',
        },
    },
    textobjects = {
        select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@comment.outer',
                ['al'] = '@class.outer',
                ['il'] = '@class.inner',
                ['ab'] = '@block.outer',
                ['ib'] = '@block.inner',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>p'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>P'] = '@parameter.inner',
            }
        },
        move = {
            enable = true,
            -- Set these jumps in the jump list.
            set_jumps = true,
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            }
        },
        lsp_interop = {
            enable = true,
            border = 'none',
            floating_preview_opts = {},
            peek_definition_code = {
                ['<leader>df'] = '@function.outer',
                ['<leader>dF'] = '@class.outer',
            }
        }
    }
}

-- }}}

-- LuaSnip {{{2
vim.cmd[[
" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
]]

require("luasnip.loaders.from_vscode")
    .lazy_load({ paths = "~/.local/share/nvim/drupal-smart-snippets/" })
require("luasnip.loaders.from_vscode").lazy_load()
-- }}}

-- LSP Lines {{{2
-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config({
  virtual_text = false,
})
-- Do the init.
require("lsp_lines").setup()
-- }}}

-- Surround {{{2
require'nvim-surround'.setup()
-- }}}

--- Highlight colors {{{2
require('nvim-highlight-colors').setup({
    render = 'virtual',
    virtual_symbol_position = 'eow',
    virtual_symbol_prefix = ' ',
    virtual_symbol_suffix = '',
})
-- }}}

-- }}}

-- vim:fdm=marker ft=lua et sts=4 sw=4
