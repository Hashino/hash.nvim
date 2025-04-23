local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local lazy_repo = "https://github.com/folke/lazy.nvim.git"

if not (vim.loop or vim.uv).fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable",
    lazy_repo, lazypath, })
end

vim.opt.rtp:prepend(lazypath)

vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Open [L]azy UI", })
