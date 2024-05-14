return { -- vertical lines for idents. also highlights current scope
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  init = function()
    require('ibl').setup {
      scope = {
        highlight = { 'CurrentScope' }, -- defined in hash.theme
        show_start = false,
      },
      indent = { char = '┆' },
    }
  end,
}
