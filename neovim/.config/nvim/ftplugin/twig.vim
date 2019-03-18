" Add twig pattern files to path to be able to configure below. Enables `gf`
" on include to jump to that file. MSK specific.
setlocal path+=/Users/delucac/Sites/mskcc_build/web/themes/mskcc/patternlab/source/_patterns/

" Disable AMP since it includes different numbers in the directories.
" setlocal path+=/Users/delucac/Sites/mskcc_amp/web/themes/mskcc/patternlab/source/_patterns/

" Set pattern for vim to recognize twig includes.
setlocal include="^\s*\{\%\s*include\|^\s*\{\%\s*embed\|^\s*\{\%\s*extends"

" Remove `@` in include for file path. MSK specific.
setlocal includeexpr=substitute(v:fname,'\@mskcc_','mskcc_','g')

" Add twig template auto pairs.
let b:AutoPairs = AutoPairsDefine({'{%' : '%}'})

" Use twig commenting instead of HTML.
setlocal commentstring={#\ %s\ #}

" Use twiglint linter.
execute('compiler twiglint')

" vim:fdm=marker ft=vim et sts=2 sw=2 ts=2
