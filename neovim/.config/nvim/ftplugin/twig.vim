" Add twig pattern files to path to be able to configure below. Enables `gf`
" on include to jump to that file. MSK specific.
setlocal path+=/Users/delucac/Sites/mskcc_build/web/themes/mskcc/patternlab/source/_patterns/,/Users/delucac/Sites/msk-design-system/src/patterns/,/Users/delucac/Sites/mskcc_amp/web/themes/mskcc/patternlab/source/_patterns/

" Always add html highlighting as well.
setlocal filetype=html.twig

" Set pattern for vim to recognize twig includes.
setlocal include="^\s*\{\%\s*include\|^\s*\{\%\s*embed\|^\s*\{\%\s*extends"

" Remove `@` in include for file path. MSK specific.
setlocal includeexpr=substitute(v:fname,'\@mskds','','g')

" Use twig commenting instead of HTML.
setlocal commentstring={#\ %s\ #}

" Use twiglint linter.
execute('compiler twiglint')

" vim:fdm=marker ft=vim et sts=2 sw=2
