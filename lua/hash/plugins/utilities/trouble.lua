return {
  'folke/trouble.nvim',
  branch = 'dev', -- IMPORTANT!
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    -- your configuration comes here
    -- or leave it empty to us the default settings
    -- refer to the configuration section below
  },
  keys = {
    { '<leader>q', '<cmd>TroubleToggle document_diagnostics<cr>', desc = 'Show [Q]uickfix diagnostics in current document' },
    { '<leader>qw', '<cmd>TroubleToggle workspace_diagnostics<cr>', desc = 'Show [Q]uifix diagnostics in whole [W]orkspace' },
  },
}
