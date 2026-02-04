local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback {
  'Hack',
  'SF Mono',
  'Monaco',
}
config.font_size = 18

-- Don't get in the way of vi.
-- See https://wezfurlong.org/wezterm/config/keyboard-concepts.html#dead-keys
config.use_dead_keys = false

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Light'
end

local function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Catppuccin Mocha'
  else
    return 'Catppuccin Frappe'
  end
end

config.color_scheme = scheme_for_appearance(get_appearance())

-- For Gruvbox
-- if wezterm.gui then
--   if wezterm.gui.get_appearance():find 'Light' then
--     config.colors = {background = '#fff8e3'}
--   end
-- end


return config
