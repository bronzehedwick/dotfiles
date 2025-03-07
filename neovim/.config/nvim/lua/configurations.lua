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

-- Don't redraw while typing macros.
vim.o.lazyredraw = true

-- Update swap file and gitgutter much faster.
vim.o.updatetime = 250

-- Command <Tab> completion.
vim.o.wildmode = 'longest:full'

-- Message popup is slightly transparent.
vim.o.pumblend = 10

-- Highlight invisible whitespace.
vim.o.list = true

vim.o.listchars = 'tab:‣ ,trail:–,nbsp:˖'

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

-- Show effects of command incrementally, as you type.
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

-- Don't open preview window when auto-completing.
vim.opt.completeopt:remove('preview')

-- Use relative line numbers. Useful for jumping.
vim.opt.relativenumber = true

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
    local gitsigns = require('gitsigns')
    local opts = {}
    opts.buffer = bufnr

    -- Navigation
    vim.keymap.set('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end, opts)

    vim.keymap.set('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end, opts)

    -- Actions
    vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, opts)
    vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, opts)

    vim.keymap.set('v', '<leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, opts)

    vim.keymap.set('v', '<leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, opts)

    vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer, opts)
    vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer, opts)
    vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, opts)
    vim.keymap.set('n', '<leader>hi', gitsigns.preview_hunk_inline, opts)

    vim.keymap.set('n', '<leader>hb', function()
      gitsigns.blame_line({ full = true })
    end, opts)

    vim.keymap.set('n', '<leader>hd', gitsigns.diffthis, opts)

    vim.keymap.set('n', '<leader>hD', function()
      gitsigns.diffthis('~')
    end, opts)

    vim.keymap.set('n', '<leader>hQ', function() gitsigns.setqflist('all') end, opts)
    vim.keymap.set('n', '<leader>hq', gitsigns.setqflist, opts)

    -- Toggles
    vim.keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame, opts)
    vim.keymap.set('n', '<leader>td', gitsigns.toggle_deleted, opts)
    vim.keymap.set('n', '<leader>tw', gitsigns.toggle_word_diff, opts)

    -- Text object
    vim.keymap.set({'o', 'x'}, 'ih', gitsigns.select_hunk, opts)
  end
}
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
        'swift',
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

-- Snipe {{{2
local snipe = require('snipe')
snipe.setup()
vim.keymap.set('n', '<M-b>', snipe.open_buffer_menu)
snipe.ui_select_menu = require("snipe.menu"):new { position = "center" }
snipe.ui_select_menu:add_new_buffer_callback(function (m)
  vim.keymap.set("n", "<esc>", function ()
    m:close()
  end, { nowait = true, buffer = m.buf })
end)
vim.ui.select = snipe.ui_select
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

-- }}}

-- vim:fdm=marker ft=lua et sts=4 sw=4
