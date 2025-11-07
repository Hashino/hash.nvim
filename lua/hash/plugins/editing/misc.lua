vim.pack.add({
  "https://github.com/nvimdev/indentmini.nvim",
  "https://github.com/VidocqH/auto-indent.nvim",
  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/numToStr/Comment.nvim",
  "https://github.com/norcalli/nvim-colorizer.lua",
  "https://github.com/windwp/nvim-autopairs",
}, { confirm = false, })

require("indentmini").setup({
  char = "┆",
  exclude = { "yaml", },
})
local colors = require("hash.plugins.theme").colors

vim.api.nvim_set_hl(0, "IndentLineCurrent", { fg = colors.light_gray, })
vim.api.nvim_set_hl(0, "IndentLine", { fg = colors.selection, })

require("auto-indent").setup({})
require("todo-comments").setup({})
require("Comment").setup({})
require("colorizer").setup({})
require("nvim-autopairs").setup({})
