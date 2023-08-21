local item_definitions = {
  CMD = "cmd",
}

local M = {
  items = {
    global = {},
    by_buffer = {},
  },
  max_length = {},
  item_definitions = item_definitions,
}

M.add_item = function(item, opts)
  local buffer = opts.buffer

  if buffer == nil then
    table.insert(M.items, item)
  else
    if M.items.by_buffer[buffer] == nil then M.items.by_buffer[buffer] = {} end

    table.insert(M.items.by_buffer[buffer], item)
  end
end

M.calculate_items = function()
  local result = vim.deepcopy(M.items.global) or {}

  local current_buf = vim.api.nvim_get_current_buf()

  local item_by_buffer = M.items.by_buffer[current_buf] or {}

  local items = vim.tbl_deep_extend("force", result, item_by_buffer)

  for _, item in ipairs(items) do
    for _, definition in pairs(item_definitions) do
      if type(item[definition] == "string") then
        M.max_length[definition] =
          math.max(M.max_length[definition] or 0, #item[definition])
      end
    end
  end

  return items
end

return M
