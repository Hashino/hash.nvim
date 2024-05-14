return { -- Theme
  'rmehri01/onenord.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  init = function()
<<<<<<< HEAD
    vim.cmd.colorscheme 'onenord' -- Load the colorscheme here.
=======
    -- Load the colorscheme here.
    vim.cmd.colorscheme 'onenord'
    vim.api.nvim_set_hl(0, 'CurrentScope', { fg = require('onenord.colors').load().light_gray }) -- used by ident-blankline
>>>>>>> 0a916f7077f474594cc98fd27e4a4183a558535b
  end,
}
