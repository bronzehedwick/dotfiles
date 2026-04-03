-- Start LSP server.
vim.lsp.enable('rust_analyzer')

-- Use tree sitter.
vim.treesitter.start()

-- Use cargo.
vim.fn.execute('compiler cargo')

-- 4 spaces is the standard in Rust.
vim.opt_local.shiftwidth = 4
