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
vim.keymap.set('n', '<M-g>s', ':Git<CR>', { silent = true })
vim.keymap.set('n', '<M-g>d', ':Gdiff<CR>', { silent = true })
vim.keymap.set('n', '<M-g>c', ':Git commit<CR>', { silent = true })
vim.keymap.set('n', '<M-g>b', ':Git blame<CR>', { silent = true })
vim.keymap.set('n', '<M-g>l', ':Gclog<CR>', { silent = true })
vim.keymap.set('n', '<M-g>p', ':Gpo<CR>', { silent = true })
vim.keymap.set('n', '<M-g>r', ':Gread<CR>', { silent = true })
vim.keymap.set('n', '<M-g>w', ':Gwrite<CR>', { silent = true })
vim.keymap.set('n', '<M-g>e', ':Gedit<CR>', { silent = true })
vim.keymap.set('n', '<M-g>u', ':Gup<CR>', { silent = true })
vim.keymap.set('n', '<M-g>f', ':Gfetch<CR>', { silent = true })
-- )}}

-- vim:fdm=marker ft=lua et sts=2 sw=2
