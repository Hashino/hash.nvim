return { -- Theme
  'rmehri01/onenord.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  init = function()
    -- Load the colorscheme here.
    vim.cmd.colorscheme 'onenord'
    vim.api.nvim_set_hl(0, 'CurrentScope', { fg = require('onenord.colors').load().light_gray })
  end,
}
