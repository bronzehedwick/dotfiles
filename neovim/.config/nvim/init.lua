if vim.fn.has('nvim-0.9') == 1 then
  -- Byte compile Lua packages for performance.
  vim.loader.enable()
end

require 'plugins'
require 'configurations'
require 'mappings'
require 'colorscheme'

-- vim:fdm=marker ft=lua et sts=2 sw=2 path=./lua
