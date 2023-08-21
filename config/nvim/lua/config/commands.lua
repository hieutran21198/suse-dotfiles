local utils = require "utils"

local M = {}

M.make_default_commands = function()
  local keybinding_definitions = require("config.keybindings").on_setup_wk

  return M.make_commands(keybinding_definitions)
end

M.make_commands = function(keybinding_definitions)
  local commands = {}

  for _, def in ipairs(keybinding_definitions) do
    local command_groups =
      utils.flat_binding_resolver(def.mappings, "", def.opts)

    for _, group in ipairs(command_groups) do
      table.insert(commands, group)
    end
  end

  return commands
end

return M
