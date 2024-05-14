-- by Hashino https://github.com/Hashino/hash.nvim/
-- _               _                  _
-- | |             | |                (_)
-- | |__   __ _ ___| |__    _ ____   ___ _ __ ___
-- | '_ \ / _` / __| '_ \  | '_ \ \ / / | '_ ` _ \
-- | | | | (_| \__ \ | | |_| | | \ V /| | | | | | |
-- |_| |_|\__,_|___/_| |_(_)_| |_|\_/ |_|_| |_| |_|
--
require 'hash.opts' -- neovim options
require 'hash.keymaps' -- global keymaps.
-- NOTE: specific plugin keymaps defined inside plugin config

-- bootstrap package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', 'https://github.com/folke/lazy.nvim.git', lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- each import loads all lua files inside the folder
-- 'a.b.c' = ~/.config/nvim/lua/a/b/c/*.lua
require('lazy').setup({
  require 'hash.theme', -- colorscheme

  -- tree, barline, statusline, terminal, notifications, git info and keybinds
  { import = 'hash.plugins.interface' },
  
  -- auto format, auto pairs, toggle comment, hilight todo, hilight scope, ts/lsp
  { import = 'hash.plugins.formatting' },

  -- auto save, fuzzy finder, auto detect tabstop and shiftwidht
  { import = 'hash.plugins.utilities' },
}, { change_detection = { notify = false } })

-- vim: ts=2 sts=2 sw=2 et
