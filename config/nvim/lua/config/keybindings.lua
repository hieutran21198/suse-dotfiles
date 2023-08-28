local M = {}

local actions = require "config.actions"

M.on_setup_wk = {
  {
    mappings = {
      ["<tab>"] = { actions.look_up, " lookup" },
      ["d"] = { '"_d', "󰅖 Delete Without Saving Content To Register" },
      ["q"] = {
        actions.buffer { key = "close_all_keep_current" },
        "󰅖 Close All Buffers (Except Current)",
      },
      ["<esc>"] = { actions.magic_escape, "󰅖 Magic Escape" },
      ["<leader>"] = {
        ["y"] = {
          name = " Yank",
          a = { actions.yank { key = "all" }, " Yank File Content" },
          r = { actions.finding { key = "yank_registers" }, " History" },
        },
        ["w"] = {
          name = " Pane",
          l = { actions.select_window "l", "→ Select Right Pane" },
          h = { actions.select_window "h", "← Select Left Pane" },
          j = { actions.select_window "j", "↓ Select Bottom Pane" },
          k = { actions.select_window "k", "↑ Select Top Pane" },
        },
        t = { actions.term { key = "toggle" }, " Toggle Terminal" },
        ["e"] = { actions.toggle_explorer, " Explorer" },
        ["f"] = {
          name = "󰈞 Finding",
          f = { actions.finding { key = "file" }, "󰈞 Find File" },

          F = {
            actions.finding {
              key = "file",
              args = "follow=true no_ignore=true hidden=true",
            },
            " Find Files (hidden)",
          },
          r = { actions.finding(), " Recent Results" },
          h = { actions.finding(), " Recent Results" },
          s = { actions.finding { key = "text" }, " Search Text" },
          t = { actions.finding { key = "todo" }, " Todo" },
          S = { actions.spectre, " Spectre" },
        },
        ["u"] = {
          name = "󰏡 Utils",
          i = {
            name = " Icons",
            i = { actions.pick_insert_icon, " Insert Icon" },
            g = { actions.finding { key = "glyph" }, "𝛲 Glyph" },
          },
          c = { actions.toggle_center_cursor, "… Center Cursor" },
          u = { actions.lazy, " Lazy Package Manager" },
          C = { actions.colorizer { key = "toggle" }, " Toggle Colorizer" },
          t = {
            name = " Terminal",
            f = { actions.term { key = "float" }, " Center Terminal" },
            o = {
              actions.term { key = "horizontal" },
              " Horizontal Terminal",
            },
            O = { actions.term { key = "vertical" }, " Vertical Terminal" },
            r = { actions.term { key = "rename" }, " Rename Terminal" },
          },
          m = {
            name = " Markdown",
            p = {
              actions.markdown { key = "preview" },
              " Preview Markdown",
            },
            t = {
              actions.markdown { key = "toggle" },
              " Toggle Preview Markdown",
            },
            x = {
              actions.markdown { key = "preview_stop" },
              "󰅖 Stop Preview Markdown",
            },
            m = {
              name = " Markdown Map",
              o = {
                actions.markdown { key = "map_open" },
                "Open Markdown Map",
              },
              w = {
                actions.markdown { key = "map_save" },
                "Save Markdown Map",
              },
              s = {
                actions.markdown { key = "map_save" },
                "Save Markdown Map",
              },
              x = {
                actions.markdown { key = "map_watch_stop" },
                "Stop Watching Markdown Map",
              },
              r = {
                actions.markdown { key = "map_watch" },
                "Run Watching Markdown Map",
              },
            },
          },
        },
        ["b"] = {
          name = " Buffer",
          ["o"] = {
            actions.buffer { key = "open" },
            "󰓩 List Opened Buffers",
          },
          ["i"] = {
            actions.guest_indent,
            " Guest Indent In Current Buffer",
          },
          ["c"] = {
            name = "󰅖 Close Buffer(s)",
            ["c"] = {
              actions.buffer { key = "close" },
              "󰅖 Close Current Buffer",
            },
            ["a"] = {
              actions.buffer {
                key = "close_all",
              },
              "󰅖 Close All Buffers",
            },
            ["k"] = {
              actions.buffer {
                key = "close_all_keep_current",
              },
              "󰅖 Close All Buffers (Except Current)",
            },
          },
        },
        ["p"] = { actions.open_command_center, "󰏡 Command Center" },
        ["l"] = {
          name = " LSP",
          m = { actions.mason, " Mason Package Manager" },
        },
      },
    },
    opts = {
      mode = "n",
      nowait = true,
      silent = true,
      noremap = true,
    },
  },
  {
    mappings = {
      ["<leader>"] = {
        ["l"] = {
          a = {
            ":'<,'>lua vim.lsp.buf.range_code_action()<CR>",
            " Code Action",
          },
        },
        ["p"] = { actions.open_command_center, "󰏡 Command Center" },
      },
      ["d"] = { '"_d', "󰅖 Delete Without Saving Content To Register" },
      ["f"] = {
        '"zy:Telescope live_grep default_text=<C-r>z<cr>',
        "󰈞 Find Current Text",
      },
    },
    opts = {
      mode = "v",
      nowait = true,
      silent = true,
      noremap = true,
    },
  },
  {
    mappings = {
      ["<ESC>"] = { "<c-\\><c-n>", " Normal Mode In Terminal" },
    },
    opts = {
      mode = "t",
      nowait = true,
      silent = true,
      noremap = true,
    },
  },
}

M.on_lsp_attach = function(_, bufnr)
  local lsp_keys = {
    name = " LSP",

    f = { actions.lsp "finder", "󰈞 Finder" },
    i = { actions.lsp("implementation", true), "󰈞 Implementation" },
    d = { actions.lsp "definition", "󰻫 Definition" },
    s = { actions.lsp("signature", true), "󰈞 Signature" },
    t = { actions.lsp "t_definition", "󰈞 Type Definition" },
    r = { actions.lsp("rename", true), "󰈞 Rename" },
    a = { actions.lsp("code_action", true), "󰈞 Code Action" },
    l = { actions.lsp_attached_clients, "󰈞 Attached Clients" },
    o = { actions.lsp "outline", "󰈞 Symbols Outline" },
    L = { actions.lsp_restart, "󰜉 Restart LSP" },
    F = { actions.lsp("format", true), "󰓆 Format Current Buffer" },

    D = { actions.lsp("diag", true), "󰈞 Document Diagnostics" },
    W = { actions.lsp("w_diag", true), "󰈞 Workspace Diagnostics" },
  }

  return {
    {
      mappings = {
        ["K"] = { actions.lsp "p_definition", "󰻫 Peek Kefinition" },
        ["<leader>"] = { l = lsp_keys },
        ["[e"] = { actions.lsp "diag_prev", " Goto Previous Diagnostic" },
        ["]e"] = { actions.lsp "diag_next", " Goto Next Diagnostic" },
      },
      opts = {
        mode = "n",
        buffer = bufnr,
        silent = true,
        noremap = true,
        nowait = false,
      },
    },
  }
end

return M
