" Use jsonlint if available, otherwise use python's built-in json linter.
if executable('jsonlint')
  execute('compiler jsonlint')
else
  execute('compiler jsontool')
endif

" vim:fdm=marker ft=vim et sts=2 sw=2
