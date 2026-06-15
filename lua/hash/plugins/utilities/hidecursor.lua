vim.pack.add({
  "https://github.com/Hashino/hidecursor.nvim",
}, { confirm = false, })

vim.keymap.set('n', '<leader>c', function()
  require('hidecursor').toggle()
end, { desc = '[T]oggle [C]ursor' })
