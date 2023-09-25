require "config.options"
require "package-manager"

if vim.g.vscode then
else
  local utils = require "utils"

  local plugins = utils.combine_plugins(
    function()
      return {
        base = require "plugins.base",
        misc = require "plugins.misc",
      }
    end
  )

  local lazy_ok, lazy = pcall(require, "lazy")
  if not lazy_ok then return end

  lazy.setup(plugins)

  require "config.auto_cmds"

  vim.cmd [[colorscheme base16-tokyo-night-terminal-dark]]
end
