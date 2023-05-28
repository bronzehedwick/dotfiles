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

-- No spell checking.
vim.o.spell = false

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

-- Higlight invisible whitespace.
vim.o.list = true

-- Set hard wrapping guide.
vim.o.colorcolumn = '80'

-- Highlight the cursor line background.
vim.opt.cursorline = true

-- Diff options.
vim.o.diffopt = 'internal,filler,vertical,algorithm:patience,linematch:60'

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
-- Window ID.
vim.opt.statusline:append('%{winnr()}')

-- }}}

-- Terminal {{{

if vim.fn.executable(brew_path() .. '/fish') then
    vim.o.shell = brew_path() .. '/fish'
end

-- Set the statusline to the process name set by the terminal.
vim.api.nvim_create_autocmd('TermOpen', {
    pattern = { '*' },
    command = [[setlocal statusline=%{b:term_title}%=%{winnr()} nonumber norelativenumber]]
})

-- }}}

-- Plugins {{{1

vim.g.undotree_SetFocusWhenToggle = true

require('Comment').setup()

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

-- LSP {{{2
local nvim_lsp = require('lspconfig')

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = {
    'cssls',
    'eslint',
    'html',
    'jsonls',
    'tsserver',
}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities
    }
end

-- Intelephense setup.
-- See https://github.com/bmewburn/intelephense-docs/blob/master/installation.md#initialisation-options
nvim_lsp.intelephense.setup({
    on_attach = on_attach,
    settings = {
        intelephense = {
            licenceKey = os.getenv('HOME') .. '/.local/share/intelephense/licence.txt'
        }
    }
})

-- }}}

-- Treesitter {{{2

require('orgmode').setup_ts_grammar()

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
        additional_vim_regex_highlighting = { 'org', 'markdown' }
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

-- Orgmode {{{2

local org_path = '~/Documents/org'
local refile_path = org_path .. '/refile.org'

require('orgmode').setup({
    org_agenda_files = {
        org_path .. '/tech.org',
        org_path .. '/projects.org',
        refile_path,
        org_path .. '/random.org',
    },
    org_default_notes_file = refile_path,
    org_indent_mode = 'noindent',
    org_ellipsis = '…',
    org_deadline_warning_days = 5,
    org_use_tag_inheritance = false,
    emacs_config = {
        executable_path = 'emacs',
        config_path = '$HOME/.dotfiles/emacs/.emacs.d/init.el'
    },
    org_todo_keyword_faces = {
        DONE = ':foreground green'
    },
    org_capture_templates = {
        t = { description = 'Task', template = '* TODO %?\n%u' },
        n = { description = 'Note', template = '* %?\n%u' },
        l = { description = 'Line Note', template = '* %?\n%a' },
        j = {
            description = 'Journal',
            template = '** %<%Y-%m-%d> %<%A>\n** %<%X>\n%?',
            target = org_path ..'/journal.org',
        },
    },
    mappings = {
        org_return = false,
        global = {
            org_agenda = '<M-a>',
            org_capture = '<M-c>'
        },
        org = {
            org_refile = '<LocalLeader>r',
            org_open_at_point = '<LocalLeader>o',
            org_archive_subtree = '<LocalLeader>$',
            org_set_tags_command = '<LocalLeader>t',
            org_toggle_archive_tag = '<LocalLeader>A',
            org_do_promote = '<LocalLeader><',
            org_do_demote = '<LocalLeader>>',
            org_meta_return = '<LocalLeader><CR>',
            org_insert_heading_respect_content = '<LocalLeader>ih',
            org_insert_todo_heading = '<LocalLeader>iT',
            org_insert_todo_heading_respect_content = '<LocalLeader>it',
            org_move_subtree_up = '<LocalLeader>k',
            org_move_subtree_down = '<LocalLeader>j',
            org_export = '<LocalLeader>e',
            org_next_visible_heading = '<LocalLeader>}',
            org_previous_visible_heading = '<LocalLeader>{',
            org_deadline = '<LocalLeader>id',
            org_schedule = '<LocalLeader>is',
            org_time_stamp = '<LocalLeader>i.',
            org_time_stamp_inactive = '<LocalLeader>i!',
            org_clock_in = '<LocalLeader>xi',
            org_clock_out = '<LocalLeader>xo',
            org_clock_cancel = '<LocalLeader>xq',
            org_clock_goto = '<LocalLeader>xj',
            org_set_effort = '<LocalLeader>xe',
        }
    }
})

-- }}}

-- }}}

-- vim:fdm=marker ft=lua et sts=4 sw=4
