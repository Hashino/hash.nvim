vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main", },
  "https://github.com/Yggdroot/hiPairs",
}, { confirm = false, })

require("nvim-treesitter").setup()

require("nvim-treesitter").install({
  "lua",
  "c",
  "rust",
  "bash",
  "html",
  "regex",
  "markdown",
  "markdown_inline",
  "vim",
  "vimdoc",
  "latex",
})

vim.g.hiPairs_hl_matchPair = { term = "bold", gui = "bold", }
vim.g.hiPairs_hl_unmatchPair = { term = "NONE", gui = "NONE", }
