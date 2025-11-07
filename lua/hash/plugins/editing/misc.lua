vim.pack.add({
  "https://github.com/nvimdev/indentmini.nvim",
  "https://github.com/VidocqH/auto-indent.nvim",
  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/numToStr/Comment.nvim",
  "https://github.com/norcalli/nvim-colorizer.lua",
  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/folke/trouble.nvim",
}, { confirm = false, })

require("indentmini").setup({
  char = "┆",
  exclude = { "yaml", },
})
local colors = require("hash.plugins.theme").colors

vim.api.nvim_set_hl(0, "IndentLineCurrent", { fg = colors.light_gray, })
vim.api.nvim_set_hl(0, "IndentLine", { fg = colors.selection, })

local win_opts = {
  type = "split",
  position = "bottom",
  relative = "win",
}

require("trouble").setup({
  focus = true,
  win = win_opts,
  preview = {
    type = "main",
    scratch = true,
  },
})

local api = require("trouble.api")

vim.keymap.set("n", "<leader>tw", function()
  api.toggle({ mode = "diagnostics", win = win_opts, })
end, { desc = "[T]rouble: [W]orkspace Diagnostics", })

vim.keymap.set("n", "<leader>tn", function()
  api.toggle({ mode = "todo", win = win_opts, })
end, { desc = "[T]rouble: [N]otes", })

vim.keymap.set("n", "<leader>ts", function()
  api.toggle({ mode = "symbols", win = win_opts, })
end, { desc = "[T]rouble: [S]ymbols", })

require("auto-indent").setup({})
require("todo-comments").setup({})
require("Comment").setup({})
require("colorizer").setup({})
require("nvim-autopairs").setup({})
