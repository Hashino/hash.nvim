return {
  { -- improve ui elements (float boxes)
    "stevearc/dressing.nvim",
    opts = {},
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        config = function()
          vim.notify = require("notify")
          require("notify").setup({
            render = "wrapped-compact",
            stages = "static",
          })
        end,
      },
    },
    config = function()
      require("noice").setup {
        cmdline = {
          format = {
            cmdline = {
              title = "",
            },
          },
          enabled = true,
          view = "cmdline_popup",
        },
        views = {
          cmdline_popup = {
            position = {
              row = "90%",
              col = "50%",
            },
            size = {
              width = 80,
              height = "auto",
            },
            win_options = {
              winhighlight = { Normal = "Normal", FloatBorder = "NoiceCmdlinePopupBorder", },
            },
          },
        },
        messages = {
          view = "mini",
        },
        routes = {
          {
            filter = {
              find = "󰆓 Autosaved",
            },
            view = "mini",
          },
        },
        presets = {
          long_message_to_split = true, -- long messages will be sent to a split
        },
      }
      vim.keymap.set("n", "<leader>N", "<cmd>Noice all<CR>", { desc = "[N]otifications", })
      vim.keymap.set("n", "<leader>n", "<cmd>Noice pick<CR>", { desc = "[N]otifications", })
    end,
  },
}
