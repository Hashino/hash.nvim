-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank({
      higroup = "CommandMode",
    })
  end,
})

-- auto-save
vim.api.nvim_create_autocmd({ "InsertLeave", "FocusLost" }, {
  callback = function()
    if
      vim.bo.modified
      and vim.bo.modifiable
      and vim.bo.buftype == ""
      and vim.fn.empty(vim.fn.expand("%:t")) == 0
      and not vim.fn.expand("%"):find(".git/COMMIT_EDITMSG")
    then
      vim.cmd("silent! write")
    end
  end,
})

-- load project-specific config
vim.api.nvim_create_autocmd("DirChanged", {
  callback = function(opts)
    local file = opts.file .. "/.nvim.lua"
    if vim.secure.read(file) then
      dofile(file)
    end
  end,
})

-- TODO: reenable when the issue is resolved
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "markdown_inline", },
  callback = function()
    vim.treesitter.stop()
  end,
})
