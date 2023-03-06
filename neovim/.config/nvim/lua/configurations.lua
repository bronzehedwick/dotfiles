local arch = vim.fn.system { 'arch' }

local function brew_path()
    if arch == 'arm64' then
        return '/opt/homebrew/bin'
    else
        return '/usr/local/bin'
    end
end

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

-- Diff options.
vim.o.diffopt = 'internal,filler,vertical,algorithm:patience'

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
-- Line number.
vim.opt.statusline:append('%l')
-- New group.
vim.opt.statusline:append('%=')
-- Window ID.
vim.opt.statusline:append('%{winnr()}')

-- }}}

-- Terminal {{{

if vim.fn.executable(brew_path() .. '/bash') then
    vim.o.shell = brew_path() .. '/bash'
end

if vim.fn.executable(brew_path() .. '/fish') then
    vim.o.shell = brew_path() .. '/fish'
end

-- Set the statusline to the process name set by the terminal.
vim.api.nvim_create_autocmd('TermOpen', {
    pattern = { '*' },
    command = [[setlocal statusline=%{b:term_title}%=%{winnr()} nonumber]]
})

vim.cmd [[
  nmap <unique> <silent> <C-s> <Plug>(PrimaryTerminalOpenDynamic)
  tmap <unique> <silent> <C-s> <C-\><C-n><C-w>c
  autocmd TermOpen * startinsert
  autocmd BufEnter term://* startinsert
]]

-- }}}

-- Plugins {{{1

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

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Buffer mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = {
    'cssls',
    'eslint',
    'html',
    'jsonls',
    'phpactor',
    'tsserver',
}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup { on_attach = on_attach }
end

-- }}}

-- Treesitter {{{2

require('orgmode').setup_ts_grammar()

require 'nvim-treesitter.configs'.setup {
    -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = {
        'bash',
        'comment',
        'css',
        'fish',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'hjson',
        'html',
        'http',
        'javascript',
        'jsdoc',
        'json5',
        'make',
        'markdown',
        'org',
        'php',
        'phpdoc',
        'python',
        'rst',
        'rust',
        'scss',
        'toml',
        'tsx',
        'twig',
        'typescript',
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
}

-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

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
            template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?',
            target = '~/org/journal.org',
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

-- Neovide {{{
if vim.fn.exists('g:neovide') then
    vim.cmd [[
    set guifont=SF\ Mono,Menlo:h19
    let g:neovide_floating_blur_amount_x = 2.0
    let g:neovide_floating_blur_amount_y = 2.0
    let g:neovide_scroll_animation_length = 0.3
    let g:neovide_hide_mouse_when_typing = v:true
    let g:neovide_input_macos_alt_is_meta = v:true
    let g:neovide_cursor_animation_length = 0.05
    let g:neovide_cursor_trail_size = 0.3
    let g:neovide_input_use_logo = v:true
  ]]
end
-- }}}

-- vim:fdm=marker ft=lua et sts=4 sw=4
