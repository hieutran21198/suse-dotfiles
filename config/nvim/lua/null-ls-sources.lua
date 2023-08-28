local M = {}

M.bind_sources = function(builtins)
  local formatting = builtins.formatting
  local diagnostics = builtins.diagnostics
  local code_actions = builtins.code_actions

  return {
    diagnostics.editorconfig_checker,

    formatting.goimports,
    formatting.goimports_reviser,
    code_actions.gomodifytags,

    formatting.fish_indent,
    diagnostics.fish,

    formatting.stylua,
    diagnostics.luacheck,

    formatting.prettierd,
    code_actions.eslint_d,
  }
end

return M
