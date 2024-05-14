local clients_lsp = function()
  local clients = vim.lsp.get_active_clients { bufnr = 0 }
  if next(clients) == nil then
    return ''
  end

  local c = {}
  for _, client in pairs(clients) do
    table.insert(c, client.name)
  end
  return ' ' .. table.concat(c, '|')
end
local function git_repo()
  local git_repo_name = vim.fn.system "basename $(git remote get-url origin) | tr -d '\n'"
  local branch = vim.fn.system "git branch --show-current 2> /dev/null | tr -d '\n'"
  if branch ~= '' then
    return '[' .. git_repo_name .. '/' .. branch .. ']'
  else
    return ''
  end
end
return { -- Simple status line in lua
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- LSP clients attached to buffer

  init = function()
    local lualine_sections = {
      lualine_a = { 'mode' },
      lualine_b = { git_repo, 'diff' },
      lualine_c = { 'diagnostics' },
      -- right side
      lualine_x = { { 'filename', path = 3 } },
      lualine_y = { clients_lsp, { 'filetype', icon_only = true } },
      lualine_z = { 'location' },
    }
    require('lualine').setup {
      options = {
        component_separators = '',
        section_separators = '',
      },
      sections = lualine_sections,
      inactive_sections = lualine_sections,
      extensions = { 'nvim-tree', 'trouble' },
    }
  end,
}
