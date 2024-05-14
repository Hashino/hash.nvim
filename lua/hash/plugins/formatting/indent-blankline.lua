return { -- vertical lines for idents. also highlights current scope
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  init = function()
    require('ibl').setup {
      scope = {
        highlight = { 'TabLine' }, -- gets highlight from colorscheme
        show_start = false,
      },
      indent = { char = '┆' },
    }
  end,
}
