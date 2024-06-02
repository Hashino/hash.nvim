return {
  'folke/trouble.nvim',
  -- branch = 'dev', -- IMPORTANT!
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    preview = {
      type = "main",
      -- when a buffer is not yet loaded, the preview window will be created
      -- in a scratch buffer with only syntax highlighting enabled.
      -- Set to false, if you want the preview to always be a real loaded buffer.
      scratch = true,
    },
  },
  -- TODO: use api commands instead
  -- need docs for that
  keys = {
    { '<leader>qd', '<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>',                   desc = 'Show [Q]uickfix diagnostics in current [D]ocument' },

    { '<leader>qw', '<cmd>Trouble diagnostics toggle focus=true<cr>',                                desc = 'Show [Q]uifix diagnostics in whole [W]orkspace' },

    { '<leader>qs', '<cmd>Trouble symbols toggle focus=true results.win = { position = right }<cr>', desc = 'Pin [Q]uick navigation pane for [S]ymbols' },
  },
}
