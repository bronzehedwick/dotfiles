" Exit if Neomake isn't loaded.
if ! exists(':Neomake')
  finish
endif

" Call Neomake on write.
call neomake#configure#automake('w')

" Configure a maker for twig linting.
let g:neomake_twig_maker = {
      \ 'exe': '/usr/local/bin/twig-lint.phar',
      \ 'args': ['lint', '--no-ansi', '--format', 'csv'],
      \ 'errorformat': '\"%f\"\,%l\,%m',
      \ }
let g:neomake_twig_enabled_makers = ['twig']

" vim:fdm=marker ft=vim et sts=2 sw=2 ts=2
