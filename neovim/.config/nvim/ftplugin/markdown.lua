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
vim.keymap.set('n', '<LocalLeader>x', function()
    vim.cmd('normal mp')
    if (string.match(vim.fn.getline('.'), '[x]')) then
        vim.cmd('normal ^f[lr ')
    else
        vim.cmd('normal ^f[lrx')
    end
    vim.cmd('normal `p')
end, { silent = true })

-- vim:fdm=marker ft=lua et sts=2 sw=2
