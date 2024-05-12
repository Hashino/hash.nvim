return {
  -- amongst your other plugins
  'akinsho/toggleterm.nvim', 
  version = '*', 
  init = function()
    require('toggleterm').setup {
      open_mapping = [[<A-t>]],
      size = 30,
      direction = 'float',
      float_opts = {
        border = 'single',
        title_pos = 'center',
      },
    }
  end,
}
