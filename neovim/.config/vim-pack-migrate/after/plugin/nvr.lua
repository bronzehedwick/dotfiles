-- Exit if not neovim and nvr isn't present.
if (not vim.fn.executable('nvr')) then
  return
end

-- Defaults for how nvr is called from other programs.
vim.env.VISUAL = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
