local M = {
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
    },
    config = function()
      local lspsaga = require "lspsaga"
      lspsaga.setup {
        finder = {
          keys = {
            expand_or_jump = "<cr>",
            vsplit = "<c-v>",
            split = "<c-x>",
            quit = { "q", "<ESC>" },
            close_in_preview = "<ESC>",
          },
        },
        definition = {
          vsplit = "<C-v>",
          split = "<C-x>",
          quit = "q",
        },
        outline = {
          win_position = "right",
          win_with = "",
          win_width = 40,
          preview_width = 0.4,
          show_detail = true,
          auto_preview = true,
          auto_refresh = true,
          auto_close = true,
          auto_resize = false,
          custom_sort = nil,
          keys = {
            expand_or_jump = "<CR>",
            quit = "q",
          },
        },
      }
    end,
  },
  {
    "ghassan0/telescope-glyph.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  { "stevearc/dressing.nvim" },
  {
    "ziontee113/icon-picker.nvim",
    dependencies = {
      "stevearc/dressing.nvim",
    },
    cmd = { "IconPickerYank", "IconPickerInsert", "IconPickerNormal" },
    opts = {
      disable_legacy_commands = true,
    },
    config = function(_, opts) require("icon-picker").setup(opts) end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "User BaseFile",
    cmd = {
      "ColorizerToggle",
      "ColorizerAttachToBuffer",
      "ColorizerDetachFromBuffer",
      "ColorizerReloadAllBuffers",
    },
    opts = { user_default_options = { names = false } },
  },
  {
    "folke/todo-comments.nvim",
    opts = {},
    event = { "BufEnter" },
    config = function(_, opts) require("todo-comments").setup(opts) end,
  },
  {
    "NMAC427/guess-indent.nvim",
    event = "VeryLazy",
    config = function(_, opts)
      require("guess-indent").setup(opts)

      vim.cmd.lua {
        args = { "require('guess-indent').set_from_buffer('auto_cmd')" },
        mods = { silent = true },
      }
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    build = "./build.sh nvim-oxi",
    cmd = "Spectre",
    opts = {
      default = {
        find = {
          -- pick one of item in find_engine [ ag, rg, ripgrep ]
          cmd = "rg",
          options = {},
        },
        replace = {
          -- pick one of item in [ sed, oxi ]
          cmd = "sed",
        },
      },
      is_insert_mode = true, -- start open panel on is_insert_mode
      mapping = {
        ["toggle_line"] = {
          map = "d",
          cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
          desc = "toggle item.",
        },
        ["enter_file"] = {
          map = "<cr>",
          cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
          desc = "open file.",
        },
        ["send_to_qf"] = {
          map = "sqf",
          cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
          desc = "send all items to quickfix.",
        },
        ["replace_cmd"] = {
          map = "src",
          cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
          desc = "replace command.",
        },
        ["show_option_menu"] = {
          map = "so",
          cmd = "<cmd>lua require('spectre').show_options()<CR>",
          desc = "show options.",
        },
        ["run_current_replace"] = {
          map = "c",
          cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
          desc = "confirm item.",
        },
        ["run_replace"] = {
          map = "R",
          cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
          desc = "replace all.",
        },
        ["change_view_mode"] = {
          map = "sv",
          cmd = "<cmd>lua require('spectre').change_view()<CR>",
          desc = "results view mode.",
        },
        ["change_replace_sed"] = {
          map = "srs",
          cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
          desc = "use sed to replace.",
        },
        ["change_replace_oxi"] = {
          map = "sro",
          cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
          desc = "use oxi to replace.",
        },
        ["toggle_live_update"] = {
          map = "sar",
          cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
          desc = "auto refresh changes when nvim writes a file.",
        },
        ["resume_last_search"] = {
          map = "sl",
          cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
          desc = "repeat last search.",
        },
        ["insert_qwerty"] = {
          map = "i",
          cmd = "<cmd>startinsert<CR>",
          desc = "insert (qwerty).",
        },
        ["insert_colemak"] = {
          map = "o",
          cmd = "<cmd>startinsert<CR>",
          desc = "insert (colemak).",
        },
        ["quit"] = {
          map = "q",
          cmd = "<cmd>lua require('spectre').close()<CR>",
          desc = "quit.",
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      {
        "linrongbin16/lsp-progress.nvim",
        event = { "VimEnter" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
      },
    },
    config = function()
      local lualine = require "lualine"

      local lsp_progress = require "lsp-progress"

      lsp_progress.setup()
      lualine.setup {
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename", lsp_progress.progress },
          lualine_x = { "encoding", "fileformat", "filetype", "filesize" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      }

      vim.cmd [[
        augroup lualine_augroup
            autocmd!
            autocmd User LspProgressStatusUpdated lua require("lualine").refresh()
        augroup END
      ]]
    end,
  },
  { "folke/neodev.nvim", opts = {} },
  {
    "Exafunction/codeium.vim",
    config = function()
      vim.keymap.set(
        "i",
        "<C-enter>",
        function() return vim.fn["codeium#Accept"]() end,
        { expr = true }
      )

      vim.keymap.set(
        "i",
        "<M-i>",
        function() return vim.fn["codeium#Accept"]() end,
        { expr = true }
      )

      vim.keymap.set(
        "i",
        "<M-j>",
        function() return vim.fn["codeium#CycleCompletions"](1) end,
        { expr = true }
      )

      vim.keymap.set(
        "i",
        "<M-k>",
        function() return vim.fn["codeium#CycleCompletions"](-1) end,
        { expr = true }
      )
    end,
  },
  {
    "ray-x/go.nvim",
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
    dependencies = {
      { "rafaelsq/nvim-goc.lua" },
    },
    config = function()
      require("go").setup()

      require("nvim-goc").setup {
        verticalSplit = false,
      }
    end,
  },
}

return M
