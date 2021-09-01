" Enable spell checking.
setlocal spell

" Use a dictionary to lookup words.
if executable('dict')
  setlocal keywordprg=dict
  " nnoremap <buffer> <silent> <S-k> :execute "split " . shellescape(&keywordprg) . "<bar> 0read !" . shellescape(&keywordprg) . " " . expand("<cword>")<bar> :Man!<CR>
endif

" Insert time in this format: [2021-09-01 Wed]
inoremap <buffer> <C-g><C-t> <C-r>=strftime("[%Y-%m-%d %a]")<cr>

" vim:fdm=marker ft=vim et sts=2 sw=2
