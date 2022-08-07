local autocmds = {}

-- Interface {{{

-- Use soft tabs.
vim.opt.expandtab = true

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

-- Format text (gq) with par if it exists.
if vim.fn.executable('par') == 1 then
  vim.opt.formatprg = 'par'
end

-- Make the jump-list behave like the tag list or a web browser.
vim.o.jumpoptions = 'stack'

-- Use ripgrep as external grep tool, if available.
if vim.fn.executable('rg') == 1 then
  vim.o.grepprg = 'rg --no-heading --vimgrep'
end

-- Automatically open, but do not go to (if there are errors) the quickfix /
-- location list window, or close it when is has become empty.
--
-- Note: Must allow nesting of autocmds to enable any customizations for quickfix
-- buffers.
-- Note: Normally, :cwindow jumps to the quickfix window if the command opens it
-- (but not if it's already open). However, as part of the autocmd, this doesn't
-- seem to happen.
autocmds.MakerQuickFix = {
  {'QuickFixCmdPost', '[^l]*', 'nested cwindow'},
  {'QuickFixCmdPost', 'l*', 'nested lwindow'},
}

-- Make list-like commands more intuitive.
vim.keymap.set('c', '<CR>', function()
  local cmdline = vim.fn.getcmdline()
  if vim.regex('\\v\\C^(ls|files|buffers)'):match_str(cmdline) then
    -- Like :ls but prompts for a buffer command.
    return '<CR>:b'
  elseif vim.regex('\\v\\C/(#|nu|num|numb|numbe|number)$'):match_str(cmdline) then
    -- Like :g//# but prompts for a command.
    return '<CR>:'
  elseif vim.regex('\\v\\C^(dli|il)'):match_str(cmdline) then
    -- Like :dlist or :ilist but prompts for a count for :djump or :ijump.
    return '<CR>:' .. cmdline:sub(1, 1) .. 'j ' .. vim.fn.split(cmdline, ' ')[1] .. '<S-Left><Left>'
  elseif vim.regex('\\v\\C^(cli|lli)'):match_str(cmdline) then
    -- Like :clist or :llist but prompts for an error/location number.
    return '<CR>:sil ' .. cmdline:sub(1, 1) .. cmdline:sub(1, 1) .. '<Space>'
  elseif vim.regex('\\C^old'):match_str(cmdline) then
    -- Like :oldfiles but prompts for an old file to edit.
    vim.opt.more = false
    return '<CR>:sil se more|e #<'
  elseif vim.regex('\\C^changes'):match_str(cmdline) then
    -- Like :changes but prompts for a change to jump to.
    vim.opt.more = false
    return '<CR>:sil se more|norm! g;<S-Left>'
  elseif vim.regex('\\C^ju'):match_str(cmdline) then
    -- Like :jumps but prompts for a position to jump to.
    vim.opt.more = false
    return '<CR>:sil se more|norm! <C-o><S-Left>'
  elseif vim.regex('\\C^marks'):match_str(cmdline) then
    -- Like :marks but prompts for a mark to jump to.
    return '<CR>:norm! `'
  elseif vim.regex('\\C^undol'):match_str(cmdline) then
    -- Like :undolist but prompts for a change to undo.
    return '<CR>:u '
  else
    return '<CR>'
  end
end, { noremap=true, expr=true })

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
-- Percentage through the file.
vim.opt.statusline:append('%p%%')

-- }}}

-- Terminal {{{

if vim.fn.executable('/usr/local/bin/bash') then
  vim.o.shell = '/usr/local/bin/bash'
end

if vim.fn.executable('/usr/local/bin/fish') then
  vim.o.shell = '/usr/local/bin/fish'
end

-- Set the statusline to the process name set by the terminal.
autocmds.terminal = {
  {'TermOpen', '*', 'setlocal statusline=%{b:term_title} nonumber'},
}

vim.cmd[[
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
  variables = {lang = 'en-US'},
  html = {
    default_attributes = {
      option = {value = nil},
      textarea = {id = nil, name = nil, cols = 10, rows = 10},
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

  -- LUA LSP {{{3
  local runtime_path = vim.split(package.path, ';')
  table.insert(runtime_path, 'lua/?.lua')
  table.insert(runtime_path, 'lua/?/init.lua')

  require'lspconfig'.sumneko_lua.setup {
    cmd = {'/usr/local/bin/lua-language-server'},
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = runtime_path,
        },
        diagnostics = {
          globals = {'vim'},
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file('', true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }
  -- }}}

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.keymap.set('n', '<C-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.keymap.set('n', '<space>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.keymap.set('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.keymap.set('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.keymap.set('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.keymap.set('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.keymap.set('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    vim.keymap.set("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    vim.keymap.set("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
    hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
    hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
    hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
    augroup lsp_document_highlight
    autocmd!
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]], false)
  end
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = { "cssls", "html", "tsserver", "jsonls", "phpactor", "pyright" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

-- }}}

-- Hop {{{2
require'hop'.setup()
vim.keymap.set('n', '<M-w>', require('hop').hint_words)
vim.keymap.set('n', '<M-p>', require('hop').hint_patterns)
vim.keymap.set('n', '<M-f>', require('hop').hint_char1)
vim.keymap.set('n', '<M-l>', require('hop').hint_lines_skip_whitespace)
vim.keymap.set('n', 's', require('hop').hint_char2)
-- }}}

-- Treesitter {{{2

require('orgmode').setup_ts_grammar()

require'nvim-treesitter.configs'.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {
    'bash',
    'c',
    'comment',
    'css',
    'fish',
    'hjson',
    'html',
    'http',
    'javascript',
    'jsdoc',
    'json5',
    'lua',
    'make',
    'markdown',
    'org',
    'php',
    'phpdoc',
    'python',
    'rst',
    'scss',
    'rust',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'yaml',
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    additional_vim_regex_highlighting = {'org'}
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
  org_todo_keyword_faces = {
    DONE = ':foreground #1f6300', -- overrides builtin color for `TODO` keyword
  },
  org_agenda_templates = {
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

require'utilities'.create_augroups(autocmds)

-- vim:fdm=marker ft=lua et sts=2 sw=2