-- Dirvish/netrw {{{

-- Disable netrw, since I'm using Dirvish instead.
vim.g.loaded_netrwPlugin = 0

-- }}}

-- Matchup {{{

-- Configure match-up off screen display.
vim.g.matchup_matchparen_offscreen = "{'method': 'popup'}"

-- Change match-up match word highlight.
vim.cmd [[
augroup matchup_matchparen_highlight
   autocmd!
   autocmd ColorScheme * hi MatchWord gui=italic guibg=transparent guifg=#156adf
augroup END
]]

-- }}}

-- JavaScript {{{

-- Enable syntax highlighting for JSDoc.
vim.g.javascript_plugin_jsdoc = 1

-- }}}

-- Emmet {{{

-- Add responsive meta tag to html5 emmet snippet.
--[[ TODO: This throws an error.
vim.g.user_emmet_settings = [[{
\  'variables': {'lang': 'en-US'},
\  'html': {
\    'default_attributes': {
\      'option': {'value': v:null},
\      'textarea': {'id': v:null, 'name': v:null, 'cols': 10, 'rows': 10},
\    },
\    'snippets': {
\      'html:5': "<!DOCTYPE html>\n"
\              ."<html lang=\"${lang}\">\n"
\              ."<head>\n"
\              ."\t<meta charset=\"${charset}\">\n"
\              ."\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
\              ."\t<title></title>\n"
\              ."</head>\n"
\              ."<body>\n\t${child}|\n</body>\n"
\              ."</html>",
\    },
\  },
\}]]
--]]

-- }}}

-- LSP {{{

require'lspconfig'.tsserver.setup{}
require'lspconfig'.cssls.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.jsonls.setup{}
require'lspconfig'.phpactor.setup{}

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
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
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
local servers = { "cssls", "html", "tsserver", "jsonls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

-- }}}

-- Hop {{{
require'hop'.setup()
vim.api.nvim_set_keymap('n', '<M-w>', "<cmd>lua require'hop'.hint_words()<cr>", {})
vim.api.nvim_set_keymap('n', '<M-p>', "<cmd>lua require'hop'.hint_patterns()<cr>", {})
vim.api.nvim_set_keymap('n', '<M-i>', "<cmd>lua require'hop'.hint_lines()<cr>", {})
vim.api.nvim_set_keymap('n', '<M-f>', "<cmd>lua require'hop'.hint_char1()<cr>", {})
vim.api.nvim_set_keymap('n', '<M-s>', "<cmd>lua require'hop'.hint_char2()<cr>", {})
-- }}}

-- Treesitter {{{

-- require'nvim-treesitter.configs'.setup {
--   ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
--   highlight = {
--     enable = true, -- false will disable the whole extension
--     disable = {},  -- list of language that will be disabled
--   },
--   matchup = {
--     enable = true
--   }
-- }

-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- }}}

-- FTerm {{{

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map('n', '<C-s>', '<CMD>lua require("FTerm").toggle()<CR>', opts)
map('t', '<C-s>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)

-- }}}

-- Orgmode {{{

require('orgmode').setup({
  org_agenda_files = '~/org/*',
  org_default_notes_file = '~/org/refile.org',
  org_indent_mode = 'indent',
  org_todo_keyword_faces = {
    DONE = ':foreground #1f6300', -- overrides builtin color for `TODO` keyword
  },
  org_agenda_templates = {
    t = { description = 'Task', template = '* TODO %?\n  %u' },
    n = { description = 'Note', template = '* %?\n  %u' },
    l = { description = 'Line Note', template = '* %?\n  %a' },
    j = {
      description = 'Journal',
      template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n  %?',
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
      org_do_promote = '<LocalLeader>>',
      org_do_demote = '<LocalLeader><',
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
      org_show_help = '<LocalLeader>?'
    }
  }
})

-- }}}

-- vim: foldmethod=marker
