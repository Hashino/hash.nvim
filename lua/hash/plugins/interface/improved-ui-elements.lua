return {
  { -- improve ui elements (float boxes)
    'stevearc/dressing.nvim',
    opts = {},
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require('notify')
      require 'notify'.setup {
        render = 'wrapped-compact',
        stages = 'static'
      }
    end
  }
}
