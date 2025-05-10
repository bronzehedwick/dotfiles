-- Re-mappings {{{

-- Set mapleader to "<space>", keeping localleader as the default "\".
vim.g.mapleader = ' '

-- Stupid shift key fixes, lifted from spf13.
vim.cmd [[
  command! -bang -nargs=* -complete=file E e<bang> <args>
  command! -bang -nargs=* -complete=file W w<bang> <args>
  command! -bang -nargs=* -complete=file Wq wq<bang> <args>
  command! -bang -nargs=* -complete=file WQ wq<bang> <args>
  command! -bang Wa wa<bang>
  command! -bang WA wa<bang>
  command! -bang Q q<bang>
  command! -bang QA qa<bang>
  command! -bang Qa qa<bang>
]]

-- Replace Ex mode mapping with repeat last macro used.
-- Ex mode can still be accessed via gQ.
vim.keymap.set('n', 'Q', '@@')

-- Re-map omni-complete to command line complete. I don't use command line
-- complete, and <C-X><C-O> is hard to type on my 34-key keyboard.
vim.keymap.set('i', '<C-V>', '<C-X><C-O>')

-- Add customized Grep that's silent and doesn't jump to the first result.
vim.cmd [[
  command! -nargs=+ Grep execute 'silent grep! <args>'
]]

-- More sane command-line history.
vim.keymap.set('c', '<C-n>', '<down>')
vim.keymap.set('c', '<C-p>', '<up>')

-- Quickly toggle the quickfix and location list.
vim.keymap.set('n', '<C-w>u', ':cclose<CR>', { silent = true })
vim.keymap.set('n', '<C-w>l', ':lclose<CR>', { silent = true })

-- }}}

-- Time {{{

-- Display date and time.
vim.keymap.set('n', '<F2>', function()
    print("It is " .. vim.fn.strftime("%A %B %e %I:%M %p"))
end)

-- Insert time into a document.
vim.keymap.set('i', '<C-g><C-t>', '<C-r>=strftime("%Y-%m-%dT%H:%M:%S")<CR>')

-- }}}

-- Quickly edit macros {{{
vim.keymap.set('n', '<leader>m', ":<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>")
-- }}}

-- Strip trailing whitespace {{{
vim.keymap.set('n', '<F5>', ':let _s=@/<Bar>:%s/\\s\\+$//e<Bar>:let @/=_s<Bar><CR>', { silent = true })
-- }}}

-- Git {{{

-- Mapping to show the current git branch.
vim.keymap.set('n', '<F3>', function()
    local branch = io.popen('git -C ' .. vim.fn.expand('%:h') .. ' cb')
    if branch ~= nil then
        print(branch:read())
        branch:close()
    end
end)

-- }}}

-- Files {{{

-- Open directory at current file path.
vim.keymap.set('n', '<leader>e', ':edit <C-R>=expand("%:p:h") . "/" <CR>')
vim.keymap.set('n', '<leader>s', ':split <C-R>=expand("%:p:h") . "/" <CR>')
vim.keymap.set('n', '<leader>v', ':vsplit <C-R>=expand("%:p:h") . "/" <CR>')

-- Shortcut to edit this file.
vim.keymap.set('n', '<leader>cc', ':edit ~/.dotfiles/neovim/.config/nvim/init.lua<CR>')

-- }}}

-- UrlView {{{
if vim.fn.executable('urlview') == 1 then
    vim.keymap.set('n', '<leader>u', function()
        local file = vim.fn.tempname()
        vim.api.nvim_command('write! ' .. file)
        require('utilities').make_modal({max_width = true})
        vim.api.nvim_command('startinsert')
        vim.fn.termopen('urlview ' .. file, {
            on_exit = function()
                vim.api.nvim_command('bdelete!')
                os.remove(file)
            end
        })
    end, { silent = true })
end
-- }}}

-- Fuzzy finding {{{
if vim.fn.executable('fzy') == 1 then
    -- Files. {{{2
    vim.keymap.set('n', '<M-/>', function()
        return require('utilities').fuzzy_search('git ls-files', 'edit')
    end)
    -- }}}
    -- Git branches. {{{2
    vim.keymap.set('n', '<M-r>', function()
        require('utilities').make_modal({max_width = true})
        vim.api.nvim_cmd({ cmd = 'startinsert' }, { output = false })
        vim.fn.termopen('git branch | grep -v "*" | fzy | xargs git checkout')
    end, { silent = true })
    -- }}}
end
-- }}}

-- Terminal {{{

-- Escape exits insert mode inside terminal.
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Quickly make the terminal the only window in terminal mode.
vim.keymap.set('t', '<M-o>', '<C-\\><C-n>:only<CR>i')
vim.keymap.set('n', '<M-o>', ':only<CR>')

-- Lua-based primary terminal.
vim.keymap.set({'n', 't'}, '<C-j>', function()
    if Term_buf_id == nil then
        vim.cmd('split')
        vim.cmd('terminal')
        Term_buf_id = vim.fn.bufnr('%')
        Term_win_id = vim.fn.bufwinid('%')
        vim.cmd('startinsert')
        return
    end
    if vim.fn.bufwinnr(Term_buf_id) == -1 then
        vim.cmd { cmd = 'sbuffer', args = { Term_buf_id } }
        Term_win_id = vim.fn.bufwinid('%')
        if vim.fn.line('.') == vim.fn.line('$') then
            vim.cmd('startinsert')
        end
    else
        if #vim.api.nvim_list_wins() > 1 then
            vim.api.nvim_win_hide(Term_win_id)
        else
            vim.cmd(':edit #')
        end
    end
end)

-- }}}

-- LSP {{{

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { buffer = ev.buf }
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', 'grwa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', 'grwr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', 'grwl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set('n', 'grD', vim.lsp.buf.type_definition, bufopts)
        if vim.fn.has('nvim-0.11') == 0 then
            vim.keymap.set('n', 'grn', vim.lsp.buf.rename, bufopts)
            vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, bufopts)
            vim.keymap.set('n', 'grr', vim.lsp.buf.references, bufopts)
            vim.keymap.set('n', 'grf', vim.lsp.buf.format, bufopts)
            vim.keymap.set('i', '<C-S>', vim.lsp.buf.signature_help, bufopts)
        end
    end,
})

-- }}}

-- Plugins {{{1

-- LuaSnip {{{2
local luasnip = require("luasnip")

vim.keymap.set({"i"}, "<C-l>", function()
    if luasnip.expandable() then
        luasnip.expand()
    else
        luasnip.jump(1)
    end
end, {silent = true})
vim.keymap.set({"i", "s"}, "<M-l>", function() luasnip.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-s>", function()
    if luasnip.choice_active() then
        luasnip.change_choice(1)
    end
end, {silent = true})
-- }}}

-- DAP {{{2

local dap = require'dap'

vim.keymap.set('n', 'gdb', dap.toggle_breakpoint)
vim.keymap.set('n', 'gdc', dap.continue)
vim.keymap.set('n', 'gdo', dap.step_over)
vim.keymap.set('n', 'gdi', dap.step_into)
vim.keymap.set('n', 'gdr', dap.repl.open)

-- }}}

-- }}}

-- vim:fdm=marker ft=lua et sts=4 sw=4
