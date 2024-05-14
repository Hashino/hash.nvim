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
  { import = 'hash.plugins.theme' },
  { import = 'hash.plugins.interface' },
  { import = 'hash.plugins.formatting' },
  { import = 'hash.plugins.utilities' },
}, { change_detection = { notify = false }, })

-- vim: ts=2 sts=2 sw=2 et
