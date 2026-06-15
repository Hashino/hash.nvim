local config = {
  api_url = "https://api.inceptionlabs.ai/v2/chat/completions",
  api_key = "sk_21d0ca1db4cd657483a5e5fd57da0644",
  model = "mercury-2",
}

vim.pack.add({
  "https://github.com/Hashino/askai.nvim",
  "https://github.com/Hashino/learning.nvim",
}, { confirm = false, })

require("learning").setup({
  eagerness = 0.25,
  provider = config,
})

vim.keymap.set("v", "<leader>le", require("learning").explain,
  { noremap = true, silent = true, })

vim.keymap.set("n", "<leader>lt", require("learning").toggle,
  { noremap = true, silent = true, })

require("askai").setup({
  provider = config,
})

vim.keymap.set({ "n", "v", }, "<leader>ai", require("askai").ask,
  { desc = "[A]sk [A]I", noremap = true, silent = true, })
