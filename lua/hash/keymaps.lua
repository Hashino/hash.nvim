-- NOTE: specific plugin keymaps defined inside plugin config

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- for quick navigation between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window", })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window", })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window", })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window", })

-- navigation in insert mode
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "navigate left in insert mode", })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "navigate right in insert mode", })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "navigate down in insert mode", })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "navigate up in insert mode", })

-- disables arrow keys
vim.keymap.set({ "i", "n", }, "<Left>", "", { desc = "", })
vim.keymap.set({ "i", "n", }, "<Right>", "", { desc = "", })
vim.keymap.set({ "i", "n", }, "<Down>", "", { desc = "", })
vim.keymap.set({ "i", "n", }, "<Up>", "", { desc = "", })

-- :q Shortcut
vim.keymap.set("n", "<A-q>", "<Cmd>q<CR>", { desc = "quick quit", })

-- edit variable value
vim.keymap.set("n", "<leader>a", "0f=lC ", { desc = "assign new value to variable", })

-- makes more sense to me that way
vim.keymap.set("x", "p", "P", { desc = "paste without replacing clipboard", })

if vim.g.neovide then
  vim.keymap.set("i", "<sc-v>", '<ESC>"+pli')
  vim.keymap.set("c", "<sc-v>", "<C-R>+")
end
