-- by Hashino https://github.com/Hashino/hash.nvim/
--  _               _                  _
-- | |             | |                (_)
-- | |__   __ _ ___| |__    _ ____   ___ _ __ ___
-- | '_ \ / _` / __| '_ \  | '_ \ \ / / | '_ ` _ \
-- | | | | (_| \__ \ | | |_| | | \ V /| | | | | | |
-- |_| |_|\__,_|___/_| |_(_)_| |_|\_/ |_|_| |_| |_|
--

require("hash.opts")     -- neovim options
require("hash.autocmds") -- autocommands
require("hash.keymaps")  -- global keymaps.

vim.pack.add({ "https://github.com/folke/lazy.nvim", })

vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>",
  { desc = "Open [L]azy UI", })

require("lazy").setup({
  spec = {
    require("hash.theme").plugin,

    { import = "hash.plugins.interface", },

    { import = "hash.plugins.formatting", },

    { import = "hash.plugins.utilities", },

    { import = "hash.plugins.debugging", },
  },
  change_detection = { notify = false, },
  rocks = { enabled = false, },
})
