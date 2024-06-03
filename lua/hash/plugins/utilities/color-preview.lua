return {
  'NvChad/nvim-colorizer.lua',
  init = function()
    require('colorizer').setup {
      html = { names = false, },
    }
  end,
}
