return {
  "jiaoshijie/undotree",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    require("undotree").setup({
      float_diff = false,
    })
    vim.keymap.set("n", "<leader>u", require("undotree").toggle, { desc = "Toggle [U]ndo Tree", })
  end,
}
