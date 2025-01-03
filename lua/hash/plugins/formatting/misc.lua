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

  { -- show colors in code
    "norcalli/nvim-colorizer.lua",
    lazy = false,
    config = function()
      require("colorizer").setup({
        "*",
        html = { names = false, },
      })
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
}
