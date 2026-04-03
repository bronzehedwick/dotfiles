-- Start LSP server.
vim.lsp.enable('sourcekit')

-- The Swift Tree Sitter implementation doesn't do smart spelling as far as I can tell.
vim.opt_local.spell = false

-- Use tree sitter.
vim.treesitter.start()

-- vim:fdm=marker ft=lua et sts=4 sw=4
