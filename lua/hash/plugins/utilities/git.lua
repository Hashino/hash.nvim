vim.pack.add({
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/tpope/vim-fugitive",
}, { confirm = false, })


local gitsigns = require("gitsigns")
vim.keymap.set("n", "<leader>gS", gitsigns.toggle_signs,
  { desc = "Toggle [G]it [S]igns", })
-- disables on startup
gitsigns.toggle_signs()

local function git_cmd(cmd)
  return "<cmd>Git " .. cmd .. "<CR>"
end

vim.keymap.set("n", "<leader>gc", git_cmd("commit"),
  { desc = "[G]it [C]ommit", })

vim.keymap.set("n", "<leader>gC", git_cmd("commit --amend"),
  { desc = "[G]it ammend [C]ommit", })

vim.keymap.set("n", "<leader>gp", git_cmd("push"),
  { desc = "[G]it [P]ush", })

vim.keymap.set("n", "<leader>gP", git_cmd("push --force"),
  { desc = "[G]it force [P]ush", })

vim.keymap.set("n", "<leader>gl", git_cmd("log"),
  { desc = "[G]it [L]og", })

vim.keymap.set("n", "<leader>gA", git_cmd("add ."),
  { desc = "[G]it [A]dd all", })
