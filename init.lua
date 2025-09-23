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

vim.keymap.set("n", "<leader>L", require("lazy.view").show,
  { desc = "Open [L]azy UI", })

require("lazy").setup({
  spec = {
    require("hash.theme").plugin,

    { import = "hash.plugins.debugging", },
    { import = "hash.plugins.editing", },
    { import = "hash.plugins.interface", },
    { import = "hash.plugins.utilities", },
  },
  change_detection = { notify = false, },
  rocks = { enabled = false, },
})
