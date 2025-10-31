return {
  { -- indent lines for context
    "nvimdev/indentmini.nvim",

    config = function()
      require("indentmini").setup({
        char = "┆",
        exclude = { "yaml", },
      })
      local colors = require("hash.theme").colors

      vim.api.nvim_set_hl(0, "IndentLineCurrent", { fg = colors.light_gray, })
      vim.api.nvim_set_hl(0, "IndentLine", { fg = colors.selection, })
    end,
  },

  { -- set indent on insert enter
    "vidocqh/auto-indent.nvim",
    opts = {},
  },

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

  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require("colorizer").setup()
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
}
