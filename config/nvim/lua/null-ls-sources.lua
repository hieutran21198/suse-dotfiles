local M = {}

M.bind_sources = function(builtins, methods)
  local formatting = builtins.formatting
  local diagnostics = builtins.diagnostics
  local code_actions = builtins.code_actions

  return {
    -- go
    diagnostics.golangci_lint.with {
      method = methods.DIAGNOSTICS_ON_SAVE,
    },
    formatting.goimports,
    formatting.goimports_reviser,
    code_actions.gomodifytags,
    code_actions.impl,

    formatting.fish_indent,
    diagnostics.fish,

    formatting.stylua,

    -- treesitter
    -- code_actions.ts_node_action,

    -- ts
    code_actions.eslint_d,
    formatting.prettierd,

    -- docker
    diagnostics.hadolint,

    -- markdown
    diagnostics.markdownlint,
    formatting.markdownlint,

    -- aws cloudformation
    diagnostics.cfn_lint,

    -- check make
    diagnostics.checkmake,

    -- gitcommit
    -- Needs npm packages commitlint and a json formatter: @commitlint/{config-conventional,cli} and commitlint-format-json.
    diagnostics.commitlint,

    -- fish
    diagnostics.fish,
    formatting.fish_indent,

    -- terraform
    diagnostics.terraform_validate,
    diagnostics.tfsec,
    formatting.terrafmt,

    -- zsh
    diagnostics.zsh,

    --shell
    formatting.shellharden,
  }
end

return M
