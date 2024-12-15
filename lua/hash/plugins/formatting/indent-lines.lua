return {
  {
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
  {
    "vidocqh/auto-indent.nvim",
    opts = {},
  },
}
