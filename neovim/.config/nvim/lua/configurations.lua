-- Architecture detection {{{
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
        -- Navigation
        vim.keymap.set('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { expr = true, buffer = bufnr })
        vim.keymap.set('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true, buffer = bufnr })
        -- Actions
        vim.keymap.set({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
        vim.keymap.set({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
        vim.keymap.set('n', '<leader>hS', gs.stage_buffer)
        vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk)
        vim.keymap.set('n', '<leader>hp', gs.preview_hunk)
        vim.keymap.set('n', '<leader>hb', function() gs.blame_line { full = true } end)
        vim.keymap.set('n', '<leader>tb', gs.toggle_current_line_blame)
        vim.keymap.set('n', '<leader>hd', gs.diffthis)
        vim.keymap.set('n', '<leader>hD', function() gs.diffthis('~') end)
        vim.keymap.set('n', '<leader>td', gs.toggle_deleted)
        -- Text object
        vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
}
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
        'xml',
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
require("luasnip.loaders.from_vscode")
    .lazy_load({ paths = "~/.local/share/nvim/drupal-smart-snippets/" })
require("luasnip.loaders.from_vscode")
    .lazy_load({ paths = { "~/.config/luasnip/" } })
require("luasnip.loaders.from_vscode").lazy_load()
-- }}}

-- LSP Lines {{{2
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '☠',
            [vim.diagnostic.severity.WARN] = '⚠︎',
            [vim.diagnostic.severity.INFO] = 'ℹ︎',
            [vim.diagnostic.severity.HINT] = '☞',
        }
    },
})
-- }}}

-- Surround {{{2
require'nvim-surround'.setup()
-- }}}

-- Highlight colors {{{2
require('nvim-highlight-colors').setup({
    render = 'virtual',
    virtual_symbol_position = 'eow',
    virtual_symbol_prefix = ' ',
    virtual_symbol_suffix = '',
})
-- }}}

-- DAP {{{2

local dap = require'dap'

dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = { os.getenv('HOME') .. '/vscode-php-debug/out/phpDebug.js' }
}

dap.configurations.php = {
    {
        type = 'php',
        request = 'launch',
        name = 'Listen for Xdebug',
        port = 9003
    }
}

-- }}}

-- Github Lite {{{2
require('ghlite').setup({
    debug = false, -- if set to true debugging information is written to ~/.ghlite.log file
    view_split = 'vsplit', -- set to empty string '' to open in active buffer
    diff_split = 'vsplit', -- set to empty string '' to open in active buffer
    comment_split = 'split', -- set to empty string '' to open in active buffer
    open_command = 'open',
    keymaps = { -- override default keymaps with the ones you prefer
        diff = {
            open_file = 'gf',
            open_file_tab = 'gt',
            open_file_split = 'gs',
            open_file_vsplit = 'gv',
            approve = '<C-A>',
        },
        comment = {
            send_comment = '<C-CR>'
        },
        pr = {
            approve = '<C-A>',
        },
    },
})
-- }}}

-- }}}

-- vim:fdm=marker ft=lua et sts=4 sw=4
