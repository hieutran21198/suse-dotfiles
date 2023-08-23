local M = {}

M.telescope_config = function()
  local telescope = require "telescope"
  local command_center = require "command_center"

  local commands = require("config.commands").make_default_commands()
  -- add, set, add_set
  command_center.add(commands, { command_center.mode.ADD })

  local opts = {
    defaults = {
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
      },
      file_ignore_patterns = { "node_modules" },
      layout_config = {
        horizontal = {
          prompt_position = "bottom",
          preview_width = 0.5,
          results_width = 0.5,
          mirror = false,
        },
        vertical = {
          mirror = false,
        },
        width = 0.95,
        height = 0.95,
      },
      mappings = {
        n = {
          ["q"] = require("telescope.actions").close,
          ["<esc>"] = require("telescope.actions").close,
        },
        i = {
          -- ["<esc>"] = require("telescope.actions").close,
        },
      },
    },

    extensions = {
      command_center = {
        components = {
          command_center.component.CATEGORY,
          command_center.component.DESC,
          command_center.component.KEYS,
        },
        sort_by = {
          command_center.component.DESC,
          command_center.component.CATEGORY,
        },
        auto_replace_desc_with_cmd = false,
      },
    },
  }

  telescope.setup(opts)

  telescope.load_extension "command_center"
  telescope.load_extension "glyph"
  -- telescope.load_extension "tailiscope"
  local all_recent = require "telescope-all-recent"

  all_recent.setup {
    scoring = {
      recency_modifier = { -- also see telescope-frecency for these settings
        [1] = { age = 240, value = 100 }, -- past 4 hours
        [2] = { age = 1440, value = 80 }, -- past day
        [3] = { age = 4320, value = 60 }, -- past 3 days
        [4] = { age = 10080, value = 40 }, -- past week
        [5] = { age = 43200, value = 20 }, -- past month
        [6] = { age = 129600, value = 10 }, -- past 90 days
      },
      -- how much the score of a recent item will be improved.
      boost_factor = 0.0001,
    },

    default = {
      disable = true, -- disable any unknown pickers (recommended)
      use_cwd = true, -- differentiate scoring for each picker based on cwd
      sorting = "recent", -- sorting: options: 'recent' and 'frecency'
    },
  }
end

return M
