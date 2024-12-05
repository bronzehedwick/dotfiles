-- Use treesitter.
vim.treesitter.start()

-- LSP.
local lsp_path = '/opt/homebrew/bin/lua-language-server'
if vim.fn.filereadable(lsp_path) == 1 then
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  vim.lsp.start({
    name = 'lua_ls',
    cmd = { lsp_path },
    root_dir = vim.fs.dirname(vim.fs.find({'package.json', '.git'})[1]),
    single_file_support = true,
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT'
        },
        workspace = {
          checkThirdParty = false,
          library = { vim.env.VIMRUNTIME }
        }
      }
    }
  })
end
