--  _               _                  _
-- | |             | |                (_)
-- | |__   __ _ ___| |__    _ ____   ___ _ __ ___
-- | '_ \ / _` / __| '_ \  | '_ \ \ / / | '_ ` _ \
-- | | | | (_| \__ \ | | |_| | | \ V /| | | | | | |
-- |_| |_|\__,_|___/_| |_(_)_| |_|\_/ |_|_| |_| |_|
--
require 'hash.opts' -- neovim options

-- bootstrap package manager
require 'init_lazy'

require('lazy').setup({
  -- tree, barline, statusline, terminal, notifications, git info and keybinds
  { import = 'hash.plugins.interface' },

  -- auto save, fuzzy finder, diagnostics, auto detect tabstop and shiftwidht
  { import = 'hash.plugins.utilities' },
}, { change_detection = { notify = false } })

-- vim: ts=2 sts=2 sw=2 et
