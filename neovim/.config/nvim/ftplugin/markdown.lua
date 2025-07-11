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

-- Smart lists.
vim.keymap.set('i', '<CR>', function()
    local line = vim.fn.trim(vim.api.nvim_get_current_line())
    local bullet = string.match(line, '^[%*|%+|%-]')
    local num_bullet = string.match(line, '^[%d]*%.')
    if not bullet and not num_bullet then
        return '<CR>'
    end
    if line == bullet or line == num_bullet then
        return '<Esc>0Do'
    end
    if num_bullet then
        return '<CR>' .. num_bullet .. ' <Esc>0<C-a>A'
    end
    return '<CR>' .. bullet .. ' '
end, { buffer = true, expr = true })

-- macOS style insert and visual mode mappings.
-- These don't work in all terminal emulators.
vim.keymap.set('i', '<D-b>', '**', { buffer = true })
vim.keymap.set('i', '<D-i>', '*', { buffer = true })

-- vim:fdm=marker ft=lua et sts=4 sw=4
