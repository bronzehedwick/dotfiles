-- Emmet {{{

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

-- LSP {{{

  -- LUA LSP {{{2
  local system_name
  if vim.fn.has('mac') == 1 then
    system_name = 'macOS'
  elseif vim.fn.has('unix') == 1 then
    system_name = 'Linux'
  elseif vim.fn.has('win32') == 1 then
    system_name = 'Windows'
  else
    print('Unsupported system for sumneko lua LSP')
  end

  local sumneko_root_path = '/usr/local/bin/lua-language-server'
  local sumneko_binary = sumneko_root_path .. '/bin/' .. system_name .. '/lua-language-server'

  local runtime_path = vim.split(package.path, ';')
  table.insert(runtime_path, 'lua/?.lua')
  table.insert(runtime_path, 'lua/?/init.lua')

  require'lspconfig'.sumneko_lua.setup {
    cmd = {sumneko_binary, '-E', sumneko_root_path .. '/main.lua'};
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
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<C-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<space>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
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

-- Hop {{{
require'hop'.setup()
vim.keymap.set('n', '<M-w>', require('hop').hint_words)
vim.keymap.set('n', '<M-p>', require('hop').hint_patterns)
vim.keymap.set('n', '<M-f>', require('hop').hint_char1)
vim.keymap.set('n', '<M-l>', require('hop').hint_lines_skip_whitespace)
vim.keymap.set('n', 's', require('hop').hint_char2)
-- }}}

-- Treesitter {{{

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
    disable = {'org'},  -- list of language that will be disabled
    additional_vim_regex_highlighting = {'org'}
  },
}

-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- }}}

-- Orgmode {{{

local org_path = '~/org'
local refile_path = org_path .. '/refile.org'
vim.keymap.set('n', '<Leader>o', ':edit ' .. org_path .. '<CR>')
vim.keymap.set('n', '<Leader>r', ':edit ' .. refile_path .. '<CR>')

require('orgmode').setup({
  org_agenda_files = {
    org_path .. '/tech.org',
    org_path .. '/projects.org',
    org_path .. '/refile.org',
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

-- vim: foldmethod=marker
