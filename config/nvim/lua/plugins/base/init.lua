local M = {
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      icons = { group = "", separator = "" },
      disable = { filetypes = { "TelescopePrompt" } },
    },
    config = function(_, opts)
      local wk = require "which-key"
      wk.setup(opts)

      local definitions = require("config.keybindings").on_setup_wk
      for _, definition in ipairs(definitions) do
        wk.register(definition.mappings, definition.opts)
      end
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {},
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    config = function(_, opts) require("nvim-tree").setup(opts) end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    event = "User BaseFile",
    cmd = {
      "TSBufDisable",
      "TSBufEnable",
      "TSBufToggle",
      "TSDisable",
      "TSEnable",
      "TSToggle",
      "TSInstall",
      "TSInstallInfo",
      "TSInstallSync",
      "TSModuleInfo",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
    },
    build = ":TSUpdate",
    opts = {
      auto_install = true, -- Install a parser for the current language if not present.
      autotag = { enable = true },
      context_commentstring = { enable = true, enable_autocmd = false },
      highlight = {
        enable = true,
        disable = function(_, bufnr) return vim.b[bufnr].large_buf end,
      },
      matchup = {
        enable = true,
        enable_quotes = true,
      },
      incremental_selection = { enable = true },
      indent = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["ak"] = { query = "@block.outer", desc = "around block" },
            ["ik"] = { query = "@block.inner", desc = "inside block" },
            ["ac"] = { query = "@class.outer", desc = "around class" },
            ["ic"] = { query = "@class.inner", desc = "inside class" },
            ["a?"] = {
              query = "@conditional.outer",
              desc = "around conditional",
            },
            ["i?"] = {
              query = "@conditional.inner",
              desc = "inside conditional",
            },
            ["af"] = { query = "@function.outer", desc = "around function " },
            ["if"] = { query = "@function.inner", desc = "inside function " },
            ["al"] = { query = "@loop.outer", desc = "around loop" },
            ["il"] = { query = "@loop.inner", desc = "inside loop" },
            ["aa"] = { query = "@parameter.outer", desc = "around argument" },
            ["ia"] = { query = "@parameter.inner", desc = "inside argument" },
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]k"] = { query = "@block.outer", desc = "Next block start" },
            ["]f"] = {
              query = "@function.outer",
              desc = "Next function start",
            },
            ["]a"] = {
              query = "@parameter.inner",
              desc = "Next parameter start",
            },
          },
          goto_next_end = {
            ["]K"] = { query = "@block.outer", desc = "Next block end" },
            ["]F"] = { query = "@function.outer", desc = "Next function end" },
            ["]A"] = {
              query = "@parameter.inner",
              desc = "Next parameter end",
            },
          },
          goto_previous_start = {
            ["[k"] = { query = "@block.outer", desc = "Previous block start" },
            ["[f"] = {
              query = "@function.outer",
              desc = "Previous function start",
            },
            ["[a"] = {
              query = "@parameter.inner",
              desc = "Previous parameter start",
            },
          },
          goto_previous_end = {
            ["[K"] = { query = "@block.outer", desc = "Previous block end" },
            ["[F"] = {
              query = "@function.outer",
              desc = "Previous function end",
            },
            ["[A"] = {
              query = "@parameter.inner",
              desc = "Previous parameter end",
            },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            [">K"] = { query = "@block.outer", desc = "Swap next block" },
            [">F"] = { query = "@function.outer", desc = "Swap next function" },
            [">A"] = {
              query = "@parameter.inner",
              desc = "Swap next parameter",
            },
          },
          swap_previous = {
            ["<K"] = { query = "@block.outer", desc = "Swap previous block" },
            ["<F"] = {
              query = "@function.outer",
              desc = "Swap previous function",
            },
            ["<A"] = {
              query = "@parameter.inner",
              desc = "Swap previous parameter",
            },
          },
        },
      },
    },
    config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    dependencies = {
      { "kkharji/sqlite.lua" },
      { "prochri/telescope-all-recent.nvim" },
      { "FeiyouG/command_center.nvim" },
    },
    config = require("config.searching").telescope_config,
  },
  {
    "RRethy/nvim-base16",
    config = function() vim.cmd "colorscheme base16-gruvbox-dark-hard" end,
  },
  {
    "dcampos/nvim-snippy",
    opts = {},
    config = function(_, opts) require("snippy").setup(opts) end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "dcampos/cmp-snippy",
    },
    event = "InsertEnter",
    opts = require("config.completion").cmp_opts,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason.nvim",
        cmd = {
          "Mason",
          "MasonInstall",
          "MasonUninstall",
          "MasonUninstallAll",
          "MasonLog",
          "MasonUpdate",
          "MasonUpdateAll",
        },
        opts = {
          ui = {
            icons = {
              package_installed = "✓",
              package_uninstalled = "✗",
              package_pending = "⟳",
            },
          },
        },
        build = ":MasonUpdate",
        config = function(_, opts) require("mason").setup(opts) end,
      },
      {
        "williamboman/mason-lspconfig.nvim",
        cmd = { "LspInstall", "LspUninstall" },
      },
    },
    config = function()
      local mlc = require "mason-lspconfig"
      mlc.setup {}

      local lsp_config = require "config.lsp"
      lsp_config.setup_diagnostics()

      local nvim_lsp_configs = require "lspconfig"
      local user_opts = require("lsp-sources").config()
      local default_opt = lsp_config.opt_builder()

      local utils = require "utils"

      mlc.setup_handlers {
        function(server_name)
          local user_opt = user_opts[server_name]

          local opt = (user_opt ~= nil and not utils.empty_tbl(user_opt))
              and user_opt
            or default_opt
          nvim_lsp_configs[server_name].setup(opt)
        end,
      }
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local nls = require "null-ls"

      nls.setup {
        sources = require("null-ls-sources").bind_sources(nls.builtins),
        ensure_installed = { "stylua" },
      }
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = { java = false },
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0,
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    },
    config = function(_, opts)
      local npairs = require "nvim-autopairs"
      npairs.setup(opts)

      local cmp_status_ok, cmp = pcall(require, "cmp")
      if cmp_status_ok then
        cmp.event:on(
          "confirm_done",
          require("nvim-autopairs.completion.cmp").on_confirm_done {
            text = false,
          }
        )
      end
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    cmd = {
      "ToggleTerm",
      "TermExec",
      "ToggleTermToggleAll",
      "ToggleTermSetName",
    },
    opts = {
      highlights = {
        Normal = { link = "Normal" },
        NormalNC = { link = "NormalNC" },
        NormalFloat = { link = "Normal" },
        FloatBorder = { link = "FloatBorder" },
        StatusLine = { link = "StatusLine" },
        StatusLineNC = { link = "StatusLineNC" },
        WinBar = { link = "WinBar" },
        WinBarNC = { link = "WinBarNC" },
      },
      size = 10,
      shading_factor = 2,
      direction = "float",
      float_opts = {
        border = "rounded",
        highlights = { border = "Normal", background = "Normal" },
      },
      close_on_exit = true,
      start_in_insert = true,
    },
  },
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("Comment").setup {
        padding = true,
        sticky = true,
        ignore = nil,
        toggler = { line = "gcc", block = "gbc" },
        opleader = { line = "gc", block = "gb" },
        extra = { above = "gcO", below = "gco", eol = "gcA" },
        mappings = { basic = true, extra = false },
        pre_hook = nil,
        post_hook = nil,
      }
    end,
  },
}

return M
