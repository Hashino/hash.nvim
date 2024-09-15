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

require("init_lazy")    -- bootstrap package manager

-- TODO: install as a plugin
require("hash.plugins.cmdline")

require("lazy").setup({
  spec = {
    require("hash.plugins.theme"),

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
