vim.api.nvim_set_hl(0, 'CurrentScope', { fg = require('onenord.colors').load().light_gray })
return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  init = function()
    require('ibl').setup {
      scope = {
        highlight = 'CurrentScope',
        show_start = false,
      },
      indent = { char = '┆' },
    }
  end,
}
