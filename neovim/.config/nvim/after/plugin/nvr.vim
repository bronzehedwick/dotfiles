" Exit if not neovim and nvr isn't present.
if ! has('nvim') || ! executable('nvr')
    finish
endif

" Defaults for how nvr is called from other programs.
let $EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
let $VISUAL = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
