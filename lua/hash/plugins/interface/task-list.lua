return { -- task list
  "Hashino/doing.nvim",
  config = function()
    require("doing").setup({
      message_timeout = 2000,
      doing_prefix = "Doing: ",

      ignored_buffers = { "NvimTree", "trouble", "no-neck-pain", },

      winbar = {
        enabled = false,
      },

      store = {
        file_name = ".tasks",
      },
    })

    local api = require("doing.api")

    vim.keymap.set("n", "<leader>de", api.edit,
      { desc = "[E]dit what tasks you`re [D]oing", })
    vim.keymap.set("n", "<leader>dn", api.done,
      { desc = "[D]o[n]e with current task", })
  end,
}
