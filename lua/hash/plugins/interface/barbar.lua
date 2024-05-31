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
        buffer_index = true,
      },
      no_name_title = ' ',

      sidebar_filetypes = { NvimTree = true, }, -- filetypes that barbar will offset
    }
  end,
  version = '^1.0.0', -- optional: only update when a new 1.x version is released
}
