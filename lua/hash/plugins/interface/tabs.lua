return { -- Tabline with nvim-tree native support
  'romgrk/barbar.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  init = function()
    require('barbar').setup {
      animation = false, -- Enable/disable animations

      icons = {
        button = '',
        buffer_index = false,
      },
      no_name_title = '[New File]',

      sidebar_filetypes = {
        ['no-neck-pain'] = { event = 'BufWinLeave', text = '', align = 'left' },
      }, -- filetypes that barbar will offset
    }
    -- nvimtree autosession workaround
    vim.g.barbar_auto_setup = false

    local api = require 'barbar.api'
    local bbye = require 'barbar.bbye'

    -- Buffer Navigation
    vim.keymap.set('n', '<tab>', function() api.goto_buffer_relative(1) end)
    vim.keymap.set('n', '<S-tab>', function() api.goto_buffer_relative(-1) end)

    -- Goto buffer in position 1 to 9
    for i = 1, 9, 1 do
      local curr = tostring(i)
      vim.keymap.set('n', '<A-' .. curr .. '>', function() api.goto_buffer(i) end)
    end

    -- Close buffer
    vim.keymap.set('n', '<A-c>', bbye.bdelete)
    vim.keymap.set('n', '<A-S-c>', api.close_all_but_current)
  end,
  version = '^1.0.0', -- optional: only update when a new 1.x version is released
}
