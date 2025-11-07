vim.pack.add({
  "https://github.com/akinsho/toggleterm.nvim",
}, { confirm = false, })

require("toggleterm").setup({
  open_mapping = [[<A-t>]],
  size = 30,
  direction = "float",
  float_opts = { border = "rounded", },
})
