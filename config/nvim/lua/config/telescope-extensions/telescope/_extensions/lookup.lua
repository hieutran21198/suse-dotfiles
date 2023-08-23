local deep_extend = function(initial, partial)
  return vim.tbl_deep_extend("force", initial, partial)
end

local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
  error "This plugin requires telescope.nvim as a depedency"
end

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local entry_display = require "telescope.pickers.entry_display"
local conf = require("telescope.config").values

local lookup = require "config.telescope-extensions.lookup"

local function setup(user_cfg) lookup.cfg = deep_extend(lookup.cfg, user_cfg) end

local function look()
  local telescope_display_maker = function(entry)
    local display = {}

    local row = {}
  end
end
