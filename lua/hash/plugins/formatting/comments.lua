return {
  { -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
    keys = {
    },
  },
  {  -- "gb"/"gc" to comment regions/lines
    'numToStr/Comment.nvim',
    opts = {},
  }
}
