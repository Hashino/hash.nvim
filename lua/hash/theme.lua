return { -- Theme
  'rmehri01/onenord.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  init = function()
    vim.cmd.colorscheme 'onenord' -- Load the colorscheme here.
  end,
}
