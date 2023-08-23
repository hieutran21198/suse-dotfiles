local deepcopy = vim.deepcopy
local deep_extend = function(initial, partial)
  return vim.tbl_deep_extend("force", initial, partial)
end

local item_definition = {
  CMD = "cmd",
  DESC = "desc",
  KEYS = "keys",
  OPTS = "opts",
  GROUP = "group",
  KEYWORD = "keyword",
  REFERENCE_TO = "reference_to",
}

local opts_definition = {
  MODE = "mode",
  BUFFER = "buffer",
  SILENT = "silent",
  NOREMAP = "noremap",
  NOWAIT = "nowait",
}

local default_opts = {
  [opts_definition.MODE] = "n",
  [opts_definition.BUFFER] = nil,
  [opts_definition.SILENT] = true,
  [opts_definition.NOREMAP] = true,
  [opts_definition.NOWAIT] = true,
}

local default_cfg = {
  converter_handler = nil,
  strict = false,
  combined_display_keys = true,
  row_elements = {
    item_definition.GROUP,
    item_definition.DESC,
    item_definition.KEYS,
  },
}

local M = {
  items = {},
  cfg = default_cfg,
}

M.validate_definition = function(tbl, def)
  for k in pairs(tbl) do
    local exist = false

    for _, def_v in pairs(def) do
      if k == def_v then exist = true end
    end

    if not exist and M.cfg.strict then
      error "please recheck the definition"
      return false
    end
  end

  return true
end

M.add = function(groups)
  local tranformed_groups = deepcopy(groups)

  if
    M.cfg.converter_handler ~= nil
    and type(M.cfg.converter_handler) == "function"
  then
    tranformed_groups = M.cfg.converter_handler(tranformed_groups)
  end

  for _, group in pairs(tranformed_groups) do
    M.add_group(group)
  end
end

M.add_group = function(group)
  local items = group.mappings
  local opts = group.opts or default_opts

  for _, mapping in pairs(items) do
    local item = deepcopy(mapping)
    if item.opts == nil then
      item.opts = opts
    else
      if not M.validate_definition(item.opts, opts_definition) then
        goto continue
      end
    end

    if not M.validate_definition(item, item_definition) then goto continue end

    if M.cfg.combined_display_keys and #item.keys > 1 then
      for _, key in ipairs(item.keys) do
        table.insert(
          M.items,
          deep_extend(item, {
            [item_definition.KEYS] = { key },
          })
        )
      end
    end

    table.insert(M.items, item)

    ::continue::
  end
end

M.filter_by_mode = function(items, mode)
  local result = {}

  for _, item in ipairs(items) do
    if item.opts.mode == mode then table.insert(result, item) end
  end

  return result
end

M.filter_by_buffer = function(items, bufnr, with_global)
  local result = {}

  for _, item in ipairs(items) do
    if item.opts.buffer == bufnr then
      table.insert(result, item)
    elseif item.opts.buffer == nil and with_global ~= nil and with_global then
      table.insert(result, item)
    end
  end

  return result
end

return M
