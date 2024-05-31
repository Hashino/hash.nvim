local function session_buttons()
  local buttons = {}
  local auto_sessions = require 'auto-session'
  local sessions = auto_sessions.get_session_files()
  for i = 1, #sessions do
    table.insert(buttons, {
      type = 'button',
      val = sessions[i].display_name:gsub(tostring(os.getenv 'HOME'), '~'),
      on_press = function()
        require('auto-session').RestoreSession(auto_sessions.get_root_dir() .. sessions[i].path)
      end,
      opts = {
        position = 'center',
        shortcut = '[' .. tostring(i) .. ']',
        cursor = 0,
        width = 70,
        align_shortcut = 'right',
        hl_shortcut = 'Keyword',
        keymap = { 'n', tostring(i), '<cmd>SessionRestoreFromFile ' .. vim.fn.stdpath 'data' .. '/sessions/' .. sessions[i].path .. '<CR>' },
      },
    })
  end
  return buttons
end

local function section(
  type,
  val, --[[optional]]
  hl, --[[string]]--[[optional]]
  spacing --[[integer]] --[[optional]]
)
  return { type = type, val = val, opts = { position = 'center', hl = hl, spacing = spacing } }
end

return {
  'goolord/alpha-nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('alpha').setup {
      layout = {
        section('padding', 2),
        section('text', { 'Previous Sessions' }, 'Type'),
        section('padding', 2),
        section('group', session_buttons(), nil, 1),
        section('padding', 2),
      },
      opts = {
        margin = 5,
      },
    }
  end,
}
