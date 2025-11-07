vim.pack.add({
  "https://github.com/danymat/neogen",
}, { confirm = false, })

require("neogen").setup({})

vim.keymap.set("n", "<leader>md", function()
  require("neogen").generate({ type = "", })
end, { desc = "[M]acro: [D]ocument Context", })
