-- by Hashino https://github.com/Hashino/hash.nvim/
--  _               _                  _
-- | |             | |                (_)
-- | |__   __ _ ___| |__    _ ____   ___ _ __ ___
-- | '_ \ / _` / __| '_ \  | '_ \ \ / / | '_ ` _ \
-- | | | | (_| \__ \ | | |_| | | \ V /| | | | | | |
-- |_| |_|\__,_|___/_| |_(_)_| |_|\_/ |_|_| |_| |_|
--
require("hash.opts")    -- neovim options
require("hash.keymaps") -- global keymaps.
-- NOTE: specific plugin keymaps defined inside plugin config

-- bootstrap package manager
require("init_lazy")

require("hash.plugins.cmdline") -- TODO: install as a plugin

require("lazy").setup({
  -- each import loads all lua files inside the folder
  -- 'a.b.c' = ~/.config/nvim/lua/a/b/c/*.lua
  spec = {
    require("hash.theme"),

    { import = "hash.plugins.interface", },

    { import = "hash.plugins.formatting", },
    { import = "hash.plugins.formatting.lsp", },

    { import = "hash.plugins.utilities", },

    { import = "hash.plugins.debugging", },
  },
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "onenord", }, },

  change_detection = {
    enabled = true, -- automatically check for config file changes and reload the ui
    notify = false, -- get a notification when changes are found
  },
}, {})
