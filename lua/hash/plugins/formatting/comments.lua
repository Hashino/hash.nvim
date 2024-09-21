return {
  { -- Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim", },
    config = true,
  },
  { -- "gb"/"gc" to comment regions/lines
    "numToStr/Comment.nvim",
    opts = {},
  },
}
