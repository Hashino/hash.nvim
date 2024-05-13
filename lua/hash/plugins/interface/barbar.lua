return { -- Tabline with nvim-tree native support
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
    require('barbar').setup {
        -- Enable/disable animations
        animation = false,  
        -- Set the filetypes which barbar will offset itself for
        icons = {
          button = '',
          buffer_index = true,
        },
        no_name_title = ' ',
        sidebar_filetypes = {
          -- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
          NvimTree = true,
        },
    }
  end,
  opts = {
    -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
    -- animation = true,
    -- insert_at_start = true,
    -- …etc.
  },
  version = '^1.0.0', -- optional: only update when a new 1.x version is released
}
