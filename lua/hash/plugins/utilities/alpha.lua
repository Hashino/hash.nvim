local function session_buttons()
  local buttons = {}

  local sessions = io.popen("ls -pa --sort=time " .. require('persisted.config').options.save_dir .. " | grep -v /"):lines()
  local i = 0
  for dir in sessions do
    local full_path = dir:gsub('%%', '/'):gsub('%.vim', '')
    local short_path = full_path:gsub(vim.fn.expand '$HOME', '~')
    i = i + 1
    table.insert(buttons, {
      type = 'button',
      val = short_path,
      on_press = function()
        require('persisted').load(nil, full_path)
      end,
      opts = {
        position = 'center',
        shortcut = '[' .. tostring(i) .. ']',
        cursor = 0,
        width = 40,
        align_shortcut = 'right',
        hl_shortcut = 'Keyword',
        keymap = {
          'n',
          tostring(i),
          function()
            require('persisted').load(nil, full_path)
          end,
        },
      },
    })
    if i == 9 then
      break
    end
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
        section('padding', 10),
        section('text', {
          [[  _               _                  _]],
          [[ | |             | |                (_)]],
          [[ | |__   __ _ ___| |__    _ ____   ___ _ __ ___]],
          [[ | '_ \ / _` / __| '_ \  | '_ \ \ / / | '_ ` _ \]],
          [[ | | | | (_| \__ \ | | |_| | | \ V /| | | | | | |]],
          [[ |_| |_|\__,_|___/_| |_(_)_| |_|\_/ |_|_| |_| |_|]],
        }, '@function'),
        section('padding', 2),
        section('text', { 'Sessions' }, 'Type'),
        section('padding', 2),
        section('group', session_buttons(), nil, 0),
        section('padding', 2),
      },
      opts = {
        margin = 5,
      },
    }
  end,
}
