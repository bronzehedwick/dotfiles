-- Start LSP server.
vim.lsp.enable('ts_ls')
vim.lsp.enable('eslint')

-- Basic JS from/require include config.
vim.opt_local.include = [[^\\s*[^\/]\\+\\(from\\\|require(['"]\\)]]
vim.opt_local.suffixesadd = '.js'

-- Use tree sitter.
vim.treesitter.start()

-- Spell check should only be enabled for comments with treesitter; it isn't.
vim.opt_local.spell = false

-- Use eslint linter.
vim.fn.execute('compiler eslint')

-- Format with prettier (range-aware).
vim.opt_local.formatexpr = "v:lua.require'utilities'.prettier_formatexpr()"

---@return boolean
local is_inside_iterable = function()
    local node = vim.treesitter.get_node()
    local iterable_types = {
        'object',
        'array',
        'named_imports',
        'import_statement',
        'import_specifier',
        'import_clause',
    }
    while node do
        if vim.tbl_contains(iterable_types, node:type()) then
            return true
        end
        node = node:parent()
    end
    return false
end

vim.keymap.set('n', 'o', function()
    require('utilities').open_line_with_comma({ direction = 'below', guard = is_inside_iterable })
end, { buffer = true })

vim.keymap.set('n', 'O', function()
    require('utilities').open_line_with_comma({ direction = 'above', guard = is_inside_iterable })
end, { buffer = true })

vim.keymap.set('n', 'dd', function()
    require('utilities').dd_with_comma_removal(is_inside_iterable)
end, { buffer = true })

-- vim:fdm=marker ft=lua et sts=4 sw=4
