-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank({
      higroup = "CommandMode",
    })
  end,
})

-- auto-save
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", }, {
  callback = function()
    if
       vim.fn.getbufvar(0, "&modifiable") == 1
       and not string.find(vim.fn.expand("%"), ".git/COMMIT_EDITMSG")
    then
      vim.cmd("silent! write")
    end
  end,
})
