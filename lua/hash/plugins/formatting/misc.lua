return {

  { -- indent lines for context
    "nvimdev/indentmini.nvim",
    dependencies = { "rmehri01/onenord.nvim", },
    config       = function()
      require("indentmini").setup({
        char = "┆",
        exclude = { "yaml", },
      })

      local colors = require("onenord.colors").load()

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
    config = function()
      require("colorizer").setup({
        "*",
        html = { names = false, },
      })
    end,
  },

  { -- auto pairs
    "cohama/lexima.vim",
  },
}
