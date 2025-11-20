vim.pack.add({
  "https://github.com/Hashino/doing.nvim",
}, { confirm = false, })

require("doing").setup({
  doing_prefix = "",
  show_remaining = false,
  show_messages = false,

  ignored_buffers = { "trouble", ".tasks", },

  winbar = { enabled = false, },
})

local doing = require("doing")

vim.keymap.set("n", "<leader>da", doing.add,
  { desc = "[D]oing: [A]dd", })

vim.keymap.set("n", "<leader>de", doing.edit,
  { desc = "[D]oing: [E]dit", })

vim.keymap.set("n", "<leader>dn", doing.done,
  { desc = "[D]oing: Do[n]e", })

vim.keymap.set("n", "<leader>dt", doing.toggle,
  { desc = "[D]oing: [T]oggle", })
