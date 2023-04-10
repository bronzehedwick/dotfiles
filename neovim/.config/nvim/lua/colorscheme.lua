vim.o.background = 'light'
if vim.env.TERM_PROGRAM ~= 'Apple_Terminal' then
  vim.o.termguicolors = true
end

require('tokyonight').setup({
    style = 'night', -- Three styles: `storm`, `moon`, `night` and `day`
    light_style = 'day', -- Theme used when the background is set to light
    transparent = false, -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a
    -- `:terminal` in Neovim
    styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = false },
        keywords = { italic = false },
        functions = {},
        variables = {},
        -- Background styles. Can be 'dark', 'transparent' or 'normal'
        sidebars = 'dark', -- style for sidebars, see below
        floats = 'dark', -- style for floating windows
    },
    sidebars = { 'qf', 'help', 'terminal', 'undotree' }, -- Set a darker
    -- background on sidebar-like windows. For example: `['qf', 'vista_kind',
    -- 'terminal', 'packer']`
    day_brightness = 0.4, -- Adjusts the brightness of the colors of the
    -- **Day** style. Number between 0 and 1, from dull to vibrant colors
    hide_inactive_statusline = false, -- Enabling this option, will hide
    -- inactive statuslines and replace them with a thin border instead. Should
    -- work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = false, -- dims inactive windows
    lualine_bold = false, -- When `true`, section headers in lualine are bold
    --- You can override specific color groups to use other groups or hex color
    --- function will be called with a ColorScheme table
    ---@param colors ColorScheme
    on_colors = function(colors) end,
    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param highlights Highlights
    ---@param colors ColorScheme
    on_highlights = function(highlights, colors) end,
})
vim.cmd('colorscheme tokyonight-day')

require('dark_notify').run()

-- vim:fdm=marker ft=lua et sts=4 sw=4
