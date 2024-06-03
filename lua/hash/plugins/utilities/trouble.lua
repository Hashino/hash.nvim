return {
  'folke/trouble.nvim',
  -- branch = 'dev', -- IMPORTANT!
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'folke/todo-comments.nvim',
  },
  opts = {
    window = {
      type = 'split',
      position = 'left',
    },
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
    -- diagnostics in current document
    {
      '<leader>qd',
      '<cmd>Trouble diagnostics toggle focus=true win.position=bottom win.relative=win filter.buf=0<cr>',
      desc = 'Show [Q]uickfix diagnostics in current [D]ocument'
    },
    -- diagnostics in whole workspace
    {
      '<leader>qw',
      "<cmd>Trouble diagnostics toggle focus=true win.position=bottom win.relative=win<cr>",
      desc = 'Show [Q]uifix diagnostics in whole [W]orkspace'
    },
    -- current document symbols
    {
      '<leader>qs',
      '<cmd>Trouble symbols toggle focus=true win.position=bottom win.relative=win<cr>',
      desc = 'Pin [Q]uick navigation pane for [S]ymbols'
    },
    -- todo-comments
    {
      '<leader>td',
      '<cmd>Trouble todo toggle focus=true win.position=bottom win.relative=win<cr>',
      desc = 'Show all todos in workspace'
    },
  },
}
