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

local column_definitions = {
  TITLE = "TITLE",
}

local opts = {
  columns = {
    column_definitions.TITLE,
  },
  sort_by = {},
  separator = " ",
  prompt_title = "Lookup",
  strict = false,
  mini_length = {
    [column_definitions.TITLE] = 8,
  },
}

local function setup(user_opts)
  opts = vim.tbl_extend("force", opts, user_opts or {})
end

local function run()
  local items = lookup.calculate_items()

  local display_handler = function(entry)
    local row = {}
    local row_config = {}

    for _, col in ipairs(opts.columns) do
      local cell = entry.value[col]

      table.insert(row, cell)
      table.insert(row_config, { width = opts.mini_length[col] })
    end

    return entry_display.create {
      separator = opts.separator,
      items = row_config,
    }(row)
  end

  local telescope_prompt = pickers.new(opts, {
    prompt_title = opts.prompt_title,
    finder = finders.new_table {
      results = items,
      entry_maker = function(entry)
        local ordinal = ""

        for _, v in ipairs(opts.sort_by) do
          ordinal = ordinal .. entry[v]
        end

        return {
          value = entry,
          display = display_handler,
          ordinal = ordinal,
        }
      end,
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)

        local selection = action_state.get_selected_entry()

        if not selection then return false end

        local cmd = selection.value(item_definitions.CMD)
        if type(cmd) == "function" then
          cmd()
        else
          cmd = vim.api.nvim_replace_termcodes(cmd, true, false, true)
          vim.api.nvim_feedkeys(cmd, "t", true)
        end

        return true
      end)
    end,
  })

  local env = vim.tbl_deep_extend("force", getfenv(), {
    vim = {
      o = {},
      go = {},
      bo = {},
      wo = {},
    },
  })

  local o = env.vim.o
  local go = env.vim.go
  local bo = env.vim.bo
  local wo = env.vim.wo

  vim.schedule(function()
    vim.bo.modifiable = true
    vim.cmd "startinsert"
  end)

  telescope_prompt.find()

  env.vim.o = o
  env.vim.go = go
  env.vim.bo = bo
  env.vim.wo = wo
end

return {
  setup = setup,
  exports = {
    lookup = run,
  },
}

--return telescope.register_extension({
--	setup = setup,
--	exports = {
--		lookup = run,
--	},
--})
