-- Enable spell checking.
vim.opt_local.spell = true

-- Support code fencing syntax highlighting for the listed languages.
vim.g.markdown_fenced_languages = {
    'bash=sh',
    'javascript',
    'js=javascript',
    'json=javascript',
    'typescript',
    'ts=typescript',
    'php',
    'html',
    'lua',
    'css'
}

-- Use a dictionary to lookup words.
if vim.fn.executable('dict') then
    vim.opt.keywordprg = 'dict'
end

-- Mapping to toggle todo list status.
vim.keymap.set('n', '<C-Space>', function()
    vim.cmd('normal mp')
    if (string.match(vim.fn.getline('.'), '[x]')) then
        vim.cmd('normal ^f[lr ')
    else
        vim.cmd('normal ^f[lrx')
    end
    vim.cmd('normal `p')
end, { silent = true })

vim.keymap.set('i', '<CR>', function()
local line = vim.api.nvim_get_current_line()
    local node = vim.treesitter.get_node {
        pos = vim.api.nvim_win_get_cursor(0)
    }
    if not node or not node:type() == 'list_item' then
        return '<CR>'
    end
    local bullet = string.match(line, '[^.]')
    if not bullet then
        return '<CR>'
    end
    local num_bullet = string.match(line, '^[%d]*%.')
    if vim.fn.trim(line) == num_bullet then
        return '<Esc>0Do'
    end
    if num_bullet then
        return '<CR>' .. num_bullet .. ' <Esc>0<C-a>A'
    end
    if vim.fn.trim(line) == bullet then
        return '<Esc>0Do'
    end
    return '<CR>' .. bullet .. ' '
end, { buffer = true, expr = true })

-- vim:fdm=marker ft=lua et sts=4 sw=4
