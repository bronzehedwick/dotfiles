require"toggleterm".setup{
  open_mapping = [[<c-s>]],
  hide_numbers = true,
  shade_terminals = false,
  start_in_insert = true,
  persist_size = true,
  direction = 'float',
  float_opts = {
    border = 'single',
      width = 78,
      height = 30,
      winblend = 3,
      highlights = {
        border = "Normal",
        background = "Normal",
      }
  }
}
