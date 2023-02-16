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

-- }}}

-- Convenience mappings {{{

-- Display date and time.
vim.keymap.set('n', '<F2>', function()
    print("It is " .. vim.fn.strftime("%a %b %e %I:%M %p"))
end)

-- Open org files.
vim.keymap.set('n', '<Leader>o', ':edit ~/Documents/org/index.org<CR>')

-- Quickly edit macros.
vim.keymap.set('n', '<leader>m', ":<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>")

-- Insert time into a document.
vim.keymap.set('i', '<C-g><C-t>', '<C-r>=strftime("%Y-%m-%dT%H:%M:%S")<CR>')

-- Clear the highlighting of hlsearch.
vim.keymap.set('n', '<C-l>', ":nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR>", { silent = true })

-- Strip trailing whitespace.
vim.keymap.set('n', '<F5>', ':let _s=@/<Bar>:%s/\\s\\+$//e<Bar>:let @/=_s<Bar><CR>', { silent = true })

-- Add command to open a git mergetool window.
vim.cmd [[
  command! MergeTool execute 'edit term://git\ mergetool'
]]

-- Open directory at current file path.
vim.keymap.set('n', '<Leader>e', ':edit <C-R>=expand("%:p:h") . "/" <CR>')
vim.keymap.set('n', '<Leader>s', ':split <C-R>=expand("%:p:h") . "/" <CR>')
vim.keymap.set('n', '<Leader>v', ':vsplit <C-R>=expand("%:p:h") . "/" <CR>')

-- Shortcut to edit this file.
vim.keymap.set('n', '<Leader>c', ':edit ~/.dotfiles/neovim/.config/nvim/init.lua<CR>')

-- Add mapping to open URLs in the current buffer.
if vim.fn.executable('urlview') == 1 then
    vim.keymap.set('n', '<Leader>u', function()
        local file = vim.fn.tempname()
        vim.api.nvim_command('write! ' .. file)
        require('utilities').make_modal()
        vim.api.nvim_command('startinsert')
        vim.fn.termopen('urlview ' .. file, {
            on_exit = function()
                vim.api.nvim_command('bdelete!')
                os.remove(file)
            end
        })
    end, { silent = true })
end

-- Fuzzy finding…
if vim.fn.executable('fzy') == 1 then
    -- Files.
    vim.keymap.set('n', '<M-/>', function()
        return require('utilities').fuzzy_search('git ls-files', 'edit')
    end)

    -- Git branches
    vim.keymap.set('n', '<M-r>', function()
        require('utilities').make_modal()
        vim.api.nvim_command('startinsert')
        vim.fn.termopen('git branch | fzy | xargs git checkout')
    end, { silent = true })
end

-- Search org files.
vim.cmd [[
  command! -nargs=+ Ogrep execute 'silent grep! <args> ~/Documents/org/'
  command! -nargs=+ Orgrep execute 'silent grep! <args> --no-ignore ~/Documents/org/'
]]

-- }}}

-- Terminal {{{

-- Escape exits insert mode inside terminal.
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Quickly make the terminal the only window in terminal mode.
vim.keymap.set('t', '<M-o>', '<C-\\><C-n>:only<CR>i<CR>')

-- M-r pastes inside terminal.
-- NOTE: This really slows down init. Not sure why.
-- map {'t', '<expr> <A-r>', '<C-\\><C-N>' .. vim.fn.nr2char(vim.fn.getchar()) .. 'pi'}

-- }}}

-- vim:fdm=marker ft=lua et sts=4 sw=4
