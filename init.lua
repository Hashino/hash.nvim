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
require("hash.plugins")  -- plugins

vim.pack.add({ "https://github.com/ibhagwan/ts-vimdoc.nvim", })
