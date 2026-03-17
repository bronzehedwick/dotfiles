-- Exit if fugitive isn't loaded. {{{
if (vim.fn.exists(':Git') == 1) then
  return
end
-- }}}

-- Fugitive commands. {{{
vim.cmd [[
command! -bang -bar -nargs=* Gpush execute 'Dispatch<bang> -dir=' .
      \ fnameescape(FugitiveWorkTree()) 'git push' <q-args>
command! -bang -bar -nargs=* Gfetch execute 'Dispatch<bang> -dir=' .
      \ fnameescape(FugitiveWorkTree()) 'git fetch' <q-args>
command! -bang -bar -nargs=* Gup execute 'Dispatch<bang> -dir=' .
      \ fnameescape(FugitiveWorkTree()) 'git up' <q-args>
command! -bang -bar -nargs=* Gpo execute 'Dispatch<bang> -dir=' .
      \ fnameescape(FugitiveWorkTree()) 'git po' <q-args>
command! -bang -bar -nargs=* Gph execute 'Dispatch<bang> -dir=' .
      \ fnameescape(FugitiveWorkTree()) 'git ph' <q-args>
]]
-- }}}

-- Fugitive mappings. {{{
vim.keymap.set('n', '<M-g>s', vim.cmd.Git, { silent = true })
vim.keymap.set('n', '<M-g>d', vim.cmd.Gdiff, { silent = true })
vim.keymap.set('n', '<M-g>c', ':Git commit<cr>', { silent = true })
vim.keymap.set('n', '<M-g>b', ':Git blame<cr>', { silent = true })
vim.keymap.set('n', '<M-g>l', vim.cmd.Gclog, { silent = true })
vim.keymap.set('n', '<M-g>p', vim.cmd.Gpo, { silent = true })
vim.keymap.set('n', '<M-g>r', vim.cmd.Gread, { silent = true })
vim.keymap.set('n', '<M-g>w', vim.cmd.Gwrite, { silent = true })
vim.keymap.set('n', '<M-g>e', vim.cmd.Gedit, { silent = true })
vim.keymap.set('n', '<M-g>u', vim.cmd.Gup, { silent = true })
vim.keymap.set('n', '<M-g>f', vim.cmd.Gfetch, { silent = true })
-- )}}

-- vim:fdm=marker ft=lua et sts=2 sw=2
