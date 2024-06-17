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

-- Open links under the cursor.
vim.keymap.set('n', 'gx', function()
    local bufnr = vim.fn.bufnr()
    if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
        return
    end

    local node = vim.treesitter.get_node()
    if not node then
        return
    end
    local text = vim.treesitter.get_node_text(node, bufnr)
    local link = require'utilities'.find_url(text)

    if not link then
        return
    end

    local cmd

    if vim.fn.has('mac') == 1 then
        cmd = '!open'
    elseif vim.fn.has('win32') == 1 then
        cmd = '!explorer'
    elseif vim.fn.executable('wslview') == 1 then
        cmd = '!wslview'
    elseif vim.fn.executable('xdg-open') == 1 then
        cmd = '!xdg-open'
    else
        return
    end

    if link:find('file://') then
        vim.cmd.edit(vim.uri_to_fname(link))
    else
        vim.fn.execute(cmd .. ' ' .. vim.fn.escape(link, '#'))
    end
end)

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
    -- Modified buffers. {{{2
    vim.keymap.set('n', '<M-m>', function()
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
        if vim.fn.winwidth(0) > 120 then
            vim.cmd('vertical split')
        else
            vim.cmd('split')
        end
        vim.cmd('terminal')
        term_buf_id = vim.fn.bufnr('%')
        term_win_id = vim.fn.bufwinid('%')
        vim.cmd('startinsert')
        return
    end
    if vim.fn.bufwinnr(term_buf_id) == -1 then
        if vim.fn.winwidth(0) > 120 then
            vim.cmd('vertical sbuffer ' .. term_buf_id)
        else
            vim.cmd { cmd = 'sbuffer', args = { term_buf_id } }
        end
        term_win_id = vim.fn.bufwinid('%')
        if vim.fn.line('.') == vim.fn.line('$') then
            vim.cmd('startinsert')
        end
    else
        vim.api.nvim_win_hide(term_win_id)
    end
end)

-- }}}

-- LSP {{{

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

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
            vim.lsp.buf.format {}
        end)

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
            vim.lsp.handlers.hover, {
                border = "single",
                style = "minimal",
            }
        ),
        function(_, result, context)
            print(_)
            print(result)
            print(context)
        end
    end,

})

-- }}}

-- Ollama {{{

vim.keymap.set({'n', 'v'}, '<leader>ol', require'ollama'.prompt)
vim.keymap.set({'n', 'v'}, '<leader>og', function()
    require'ollama'.prompt('Generate_Code')
end)

-- }}}

-- vim:fdm=marker ft=lua et sts=4 sw=4
