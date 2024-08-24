return {
  { -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'todo-comments'.setup {}
    end
  },
  { -- "gb"/"gc" to comment regions/lines
    'numToStr/Comment.nvim',
    opts = {},
  }
}
