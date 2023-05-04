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
-- vim.cmd [[
--   command! -nargs=+ Grep execute 'silent grep! <args>'
-- ]]

-- More sane command-line history.
vim.keymap.set('c', '<C-n>', '<down>')
vim.keymap.set('c', '<C-p>', '<up>')

-- }}}

-- Window movement {{{
vim.keymap.set({ 'n', 't' }, '<M-1>', '<cmd>execute 1 .. "wincmd w"<cr>')
vim.keymap.set({ 'n', 't' }, '<M-2>', '<cmd>execute 2 .. "wincmd w"<cr>')
vim.keymap.set({ 'n', 't' }, '<M-3>', '<cmd>execute 3 .. "wincmd w"<cr>')
vim.keymap.set({ 'n', 't' }, '<M-4>', '<cmd>execute 4 .. "wincmd w"<cr>')
vim.keymap.set({ 'n', 't' }, '<M-5>', '<cmd>execute 5 .. "wincmd w"<cr>')
vim.keymap.set({ 'n', 't' }, '<M-6>', '<cmd>execute 6 .. "wincmd w"<cr>')
-- }}}

-- Time {{{

-- Display date and time.
vim.keymap.set('n', '<F2>', function()
    print("It is " .. vim.fn.strftime("%a %b %e %I:%M %p"))
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

-- Add command to open a git mergetool window.
vim.cmd [[
  command! MergeTool execute 'edit term://git\ mergetool'
]]

-- Mapping to show the current git branch.
vim.keymap.set('n', '<F3>', function()
    local branch = io.popen('git cb')
    print(branch:read())
    branch:close()
end)

-- }}}

-- Files {{{

-- Open directory at current file path.
vim.keymap.set('n', '<leader>e', ':edit <C-R>=expand("%:p:h") . "/" <CR>')
vim.keymap.set('n', '<leader>s', ':split <C-R>=expand("%:p:h") . "/" <CR>')
vim.keymap.set('n', '<leader>v', ':vsplit <C-R>=expand("%:p:h") . "/" <CR>')

-- Shortcut to edit this file.
vim.keymap.set('n', '<leader>c', ':edit ~/.dotfiles/neovim/.config/nvim/init.lua<CR>')

-- }}}

-- Org {{{

-- Open org files.
vim.keymap.set('n', '<leader>o', ':edit ~/Documents/org/index.org<CR>')

-- Search org files.
vim.cmd [[
  command! -nargs=+ Ogrep execute 'silent grep! <args> ~/Documents/org/'
  command! -nargs=+ Orgrep execute 'silent grep! <args> --no-ignore ~/Documents/org/'
]]

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
    -- Buffers. {{{2
    vim.keymap.set('n', '<M-b>', function()
        local buffers = vim.api.nvim_cmd(
            { cmd = 'buffers' },
            { output = true }
        )
        require('utilities').make_modal()
        vim.api.nvim_cmd({ cmd = 'startinsert' }, { output = false })
        local id = nil
        vim.fn.termopen('echo "' .. buffers .. '" | fzy', {
            stdout_buffered = true,
            on_stdout = function(chan_id, data, name)
                local stdout = data[table.maxn(data) - 1]
                local t = {}
                for i in string.gmatch(stdout, "%S+") do
                    table.insert(t, i)
                end
                id = t[2]
            end,
            on_exit = function()
                vim.api.nvim_cmd(
                    { cmd = 'bdelete', bang = true },
                    { output = false }
                )
                vim.api.nvim_cmd(
                    { cmd = 'buffer', args = { id } },
                    { output = false }
                )
            end
        })
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
    if term_buf_id == nil then
        vim.cmd('split')
        vim.cmd('terminal')
        term_buf_id = vim.fn.bufnr('%')
        term_win_id = vim.fn.bufwinid('%')
        vim.cmd('startinsert')
        return
    end
    if vim.fn.bufwinnr(term_buf_id) == -1 then
        vim.cmd { cmd = 'sbuffer', args = { term_buf_id } }
        term_win_id = vim.fn.bufwinid('%')
        vim.cmd('startinsert')
    else
        vim.api.nvim_win_hide(term_win_id)
    end
end)

-- }}}

-- vim:fdm=marker ft=lua et sts=4 sw=4
