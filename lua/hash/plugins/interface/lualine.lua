local clients_lsp = function()
  local bufnr = vim.api.nvim_get_current_buf()

  local clients = vim.lsp.get_active_clients({bufnr = 0})
  if next(clients) == nil then
    return ''
  end

  local c = {}
  for _, client in pairs(clients) do
    table.insert(c, client.name)
  end
  return '\u{f085} ' .. table.concat(c, '|')
end

local full_file_path = function()
  return vim.api.nvim_buf_get_name(0):gsub(vim.fn.expand '$HOME', '~')
end

return { -- Simple status line in lua
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- LSP clients attached to buffer

  init = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = '',
        section_separators = '',
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { full_file_path },
        lualine_x = { clients_lsp },
        lualine_y = { '' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = { 'nvim-tree' },
    }
  end,
}
