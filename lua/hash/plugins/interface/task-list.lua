return { -- task list
  "Hashino/doing.nvim",
  branch = "main",
  config = function()
    require("doing").setup({
      message_timeout = 2000,
      doing_prefix = "",
      show_remaining = true,

      ignored_buffers = { "NvimTree", "trouble", "no-neck-pain", },

      winbar = {
        enabled = false,
      },

      edit_win_config = {
        width = 60,
        height = 15,
      },

      store = {
        file_name = ".tasks",
      },
    })

    local doing = require("doing")

    vim.keymap.set("n", "<leader>da", doing.add,
      { desc = "[D]oing: [A]dd", })

    vim.keymap.set("n", "<leader>de", doing.edit,
      { desc = "[D]oing: [E]dit", })

    vim.keymap.set("n", "<leader>dn", doing.done,
      { desc = "[D]oing: Do[n]e", })

    vim.keymap.set("n", "<leader>dt", doing.toggle,
      { desc = "[D]oing: [T]oggle", })

    vim.keymap.set("n", "<leader>ds", function()
      vim.notify(doing.status(true), vim.log.levels.INFO,
        { title = "Doing:", icon = "", })
    end, { desc = "[D]oing: [S]tatus", })
  end,
}
