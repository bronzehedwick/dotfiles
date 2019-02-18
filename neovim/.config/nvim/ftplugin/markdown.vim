" Enable spell checking.
setlocal spell

" Support YAML and TOML front matter syntax highlighting, via vim-markdown.
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1

" If an H1 is used as a file heading, don't fold it, via vim-markdown.
let g:vim_markdown_folding_style_pythonic = 1

" Turn on vim-markdown plugin.
packadd vim-markdown

" vim:fdm=marker ft=vim et sts=2 sw=2 ts=2
