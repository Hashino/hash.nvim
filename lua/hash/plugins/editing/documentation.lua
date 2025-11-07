vim.pack.add({
  "https://github.com/OXY2DEV/markview.nvim",
  "https://github.com/OXY2DEV/helpview.nvim",
}, { confirm = false, })

require("markview").setup({
  experimental = {
    check_rtp_message = false,
  },
})

require("helpview").setup({})
