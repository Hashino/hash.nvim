-- by Hashino https://github.com/Hashino/hash.nvim/
--  _               _                  _
-- | |             | |                (_)
-- | |__   __ _ ___| |__    _ ____   ___ _ __ ___
-- | '_ \ / _` / __| '_ \  | '_ \ \ / / | '_ ` _ \
-- | | | | (_| \__ \ | | |_| | | \ V /| | | | | | |
-- |_| |_|\__,_|___/_| |_(_)_| |_|\_/ |_|_| |_| |_|
--
require 'hash.opts'    -- neovim options
require 'hash.keymaps' -- global keymaps.
-- NOTE: specific plugin keymaps defined inside plugin config

-- bootstrap package manager
require 'init_lazy'

-- TODO: Padronize plugins configuration
--  [-] keymaps

-- each import loads all lua files inside the folder
-- 'a.b.c' = ~/.config/nvim/lua/a/b/c/*.lua
require('lazy').setup({
    -- colorscheme
    require 'hash.theme',

    -- tree, barline, statusline, terminal, notifications, git info and keybinds
    { import = 'hash.plugins.interface' },

    -- auto format, auto pairs, toggle comment, hilight todo, hilight scope, ts/lsp
    { import = 'hash.plugins.formatting' },

    -- auto save, fuzzy finder, diagnostics, auto detect tabstop and shiftwidht
    { import = 'hash.plugins.utilities' },

    { import = 'hash.plugins.debugging' },
  },
  {
    change_detection = { notify = false }
  })
