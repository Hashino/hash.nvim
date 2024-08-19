return {
  'folke/trouble.nvim',
  -- branch = 'dev', -- IMPORTANT!
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'folke/todo-comments.nvim',
  },
  opts = {
    focus = true,
    win = {
      type = 'split',
      position = 'bottom',
      relative = 'win'
    },
    preview = {
      type = "main",
      scratch = true,
    },
  },
  -- TODO: use api commands instead
  -- need docs for that
  keys = {
    -- diagnostics in current document
    {
      '<leader>td',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = '[T]rouble: [D]ocument Diagnostics'
    },
    -- diagnostics in whole workspace
    {
      '<leader>tw',
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = '[T]rouble: [W]orkspace Diagnostics'
    },
    -- todo-comments
    {
      '<leader>tn',
      '<cmd>Trouble todo toggle <cr>',
      desc = '[T]rouble: [N]otes'
    },
    -- current document symbols
    {
      '<leader>ts',
      '<cmd>Trouble symbols toggle<cr>',
      desc = '[T]rouble: [S]ymbols'
    },
  },
}
