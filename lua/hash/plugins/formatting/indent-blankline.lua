return { -- vertical lines for idents. also highlights current scope
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  init = function()
    require('ibl').setup {
      scope = {
<<<<<<< HEAD
        highlight = { 'TabLine' }, -- gets highlight from colorscheme
=======
        highlight = { 'CurrentScope' }, -- defined in hash.theme
>>>>>>> 0a916f7077f474594cc98fd27e4a4183a558535b
        show_start = false,
      },
      indent = { char = '┆' },
    }
  end,
}
