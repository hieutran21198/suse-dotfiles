local M = {}

M.cmp_opts = function()
  local cmp = require "cmp"
  local utils = require "utils"
  local snip_status_ok, snippy = pcall(require, "snippy")
  local lspkind_status_ok, lspkind = pcall(require, "lspkind")
  local border_opts = {
    border = "rounded",
    winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
  }

  local cmp_select_next_handler = function(fallback)
    if cmp.visible() then
      cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
    else
      if snippy.can_expand_or_advance() then
        snippy.expand_or_advance()
      elseif utils.has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end
  end

  local cmp_select_previous_handler = function(fallback)
    if cmp.visible() then
      cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
    else
      if snippy.can_jump(-1) then
        snippy.previous()
      else
        fallback()
      end
    end
  end

  return {
    enabled = function()
      local dap_prompt = utils.plugin_available "cmp-dap"
        and vim.tbl_contains(
          { "dap-repl", "dapui_watches", "dapui_hover" },
          vim.api.nvim_get_option_value("filetype", { buf = 0 })
        )

      if
        vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt"
        and not dap_prompt
      then
        return false
      end

      return vim.g.cmp_enabled
    end,
    preselect = cmp.PreselectMode.None,
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = lspkind_status_ok and lspkind.cmp_format(base.lspkind) or nil,
    },
    snippet = {
      expand = function(args)
        if snip_status_ok then snippy.expand_snippet(args.body) end
      end,
    },
    duplicates = {
      nvim_lsp = 1,
      luasnip = 1,
      cmp_tabnine = 1,
      buffer = 1,
      path = 1,
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    window = {
      completion = cmp.config.window.bordered(border_opts),
      documentation = cmp.config.window.bordered(border_opts),
    },
    mapping = {
      ["<Up>"] = cmp.mapping.select_prev_item {
        behavior = cmp.SelectBehavior.Select,
      },
      ["<Down>"] = cmp.mapping.select_next_item {
        behavior = cmp.SelectBehavior.Select,
      },
      ["<C-j>"] = cmp.mapping(cmp_select_next_handler, { "i", "s" }),
      ["<C-k>"] = cmp.mapping(cmp_select_previous_handler, { "i", "s" }),
      ["<PageUp>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<PageDown>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<C-e>"] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      ["<CR>"] = cmp.mapping.confirm { select = false },
      ["<Tab>"] = cmp.mapping(cmp_select_next_handler, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(cmp_select_previous_handler, { "i", "s" }),
    },
    sources = cmp.config.sources {
      {
        name = "nvim_lsp",
        priority = 1000,
        entry_filter = function(entry)
          local kind =
            require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
          if kind == "Text" then return false end

          return true
        end,
      },
      { name = "snippy", priority = 750 },
      { name = "buffer", priority = 500 },
      { name = "path", priority = 250 },
    },
  }
end

return M
