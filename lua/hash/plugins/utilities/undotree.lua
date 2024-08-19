return {
  "jiaoshijie/undotree",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    require 'undotree'.setup {
      float_diff = false,
      -- layout = 'left_left_bottom',
      -- position = 'bottom',
    }
    vim.keymap.set('n', '<leader>u', require('undotree').toggle, { desc = '[U]ndo Tree' })
  end,
}
