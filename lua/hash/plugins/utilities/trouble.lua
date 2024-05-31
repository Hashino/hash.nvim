return {
  'folke/trouble.nvim',
  -- branch = 'dev', -- IMPORTANT!
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    -- your configuration comes here
    -- or leave it empty to us the default settings
    -- refer to the configuration section below
  },
  -- TODO: use api commands instead
  keys = {
    { '<leader>qd', '<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>', desc = 'Show [Q]uickfix diagnostics in current [D]ocument' },
    { '<leader>qw', '<cmd>Trouble diagnostics toggle focus=true<cr>', desc = 'Show [Q]uifix diagnostics in whole [W]orkspace' },
    { '<leader>qs', '<cmd>Trouble symbols toggle results.win = { position = right }<cr>', desc = '[P]in [Q]uifix diagnostics ub current document' },
  },
}
