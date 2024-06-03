return {
  {
    "nvimdev/indentmini.nvim",
    config = function()
      require("indentmini").setup({
        char = '┆'
      }) -- use default config

      vim.api.nvim_set_hl(0, "IndentLineCurrent", { link = "TabLine" })
      vim.api.nvim_set_hl(0, "IndentLine", { link = "WinSeparator" })
    end,
  },
  -- {
  --   'vidocqh/auto-indent.nvim',
  --   opts = {},
  -- }
}
