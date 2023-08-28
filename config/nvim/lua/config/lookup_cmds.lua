local actions = require "config.actions"
local definition = require "lookup.definition"

local M = {
  {
    mappings = {
      {
        [definition.item.CMD] = actions.toggle_explorer,
        [definition.item.DESC] = "Toggle Explorer",
      },
    },
  },
}

return M
