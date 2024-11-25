return {
  {
    "danymat/neogen",
    config = function()
      require("neogen").setup {}
      local neogen = require("neogen")
      vim.keymap.set("n", "<leader>md", function()
        require("neogen").generate({ type = "", })
      end, { desc = "[M]acro: [D]ocument Context", })
    end,
  },
}
