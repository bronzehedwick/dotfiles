local create_augroups = require 'utilities'.create_augroups
local autocmds = {}

-- Detect Drupal .theme files.
autocmds.drupal_theme = {
  { 'BufRead,BufNewFile', '*.theme', 'set filetype=php' },
}

create_augroups(autocmds)
