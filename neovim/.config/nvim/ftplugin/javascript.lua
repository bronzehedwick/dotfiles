-- The JS Treesitter implementation doesn't do smart spelling as far as I can tell.
vim.opt_local.spell = false

-- Basic JS from/require include config.
vim.opt.include = [[^\\s*[^\/]\\+\\(from\\\|require(['"]\\)]]
vim.opt.suffixesadd = '.js'

-- Use eslint linter.
vim.fn.execute('compiler eslint')

-- LSP.
local lsp_path = '/opt/homebrew/bin/tsserver'
if vim.fn.filereadable(lsp_path) == 1 then
    vim.lsp.start({
        name = 'typescript',
        init_options = { hostInfo = 'neovim' },
        cmd = { 'typescript-language-server', '--stdio' },
        root_dir = vim.fs.dirname(vim.fs.find({
            'package.json',
            'jsconfig.json',
            '.git'
        }, { upward = true })[1]),
    })
end

---@return boolean
local is_inside_iterable = function()
    local node = vim.treesitter.get_node { pos = vim.api.nvim_win_get_cursor(0) }
    local nodes_active_in = {
        'object',
        'array',
    }
    if not node or not vim.tbl_contains(nodes_active_in, node:type()) then
        return false
    end
    local line = vim.api.nvim_get_current_line()
    if string.find(line, '}') or string.find(line, ']') then
        return false
    end
    return true
end

vim.keymap.set(
    'n',
    'o',
    function()
        if not is_inside_iterable() then
            return 'o'
        end
        local line = vim.api.nvim_get_current_line()
        local needs_comma = string.find(line, '[^,{[]$')
        if needs_comma then
            return 'A,<CR>'
        else
            return 'o'
        end
    end,
    { buffer = true, expr = true }
)

vim.keymap.set(
    'n',
    'O',
    function()
        if not is_inside_iterable() then
            return 'O'
        end
        local line_num = vim.fn.line('.')
        local line_above = vim.fn.getline(line_num - 1)
        local needs_comma = string.find(line_above, '[^,{[]$')
        if needs_comma then
            return '<Up>A,<CR>'
        else
            return 'O'
        end
    end,
    { buffer = true, expr = true }
)

vim.keymap.set(
    'n',
    'dd',
    function()
        if not is_inside_iterable() then
            return 'dd'
        end
        local line = vim.api.nvim_get_current_line()
        local needs_comma_removed = string.find(line, '[^,{[]$')
        if needs_comma_removed then
            return 'dd<Up>$x'
        else
            return 'dd'
        end
    end,
    { buffer = true, expr = true }
)

-- vim:fdm=marker ft=lua et sts=4 sw=4
