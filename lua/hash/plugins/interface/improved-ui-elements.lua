return {
  { -- improve ui elements (float boxes)
    "stevearc/dressing.nvim",
    opts = {
      select = {
        backend = { "nui", },
        nui = {
          min_width = 7,
          min_height = 2,
        },
      },
    },
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
      require("noice").setup({
        cmdline = {
          format = {
            cmdline = {
              title = "",
            },
          },
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
          view_search = "mini", -- view for search count messages. Set to `false` to disable
        },
        routes = {
          {
            filter = {
              find = "󰆓 Autosaved",
            },
            view = "mini",
          },
          {
            filter = {
              any = {
                { find = "Found a swap file", },
                { find = "Ignoring swapfile", },
              },
            },
            skip = true,
          },
          {
            filter = {
              event = "msg_show",
              kind = "confirm",
            },
            view = "confirm",
          },
          {
            filter = {
              event = "msg_show",
              min_height = 2,
            },
            view = "messages",
          },
        },
      })
      vim.keymap.set("n", "<leader>N", "<cmd>Noice all<CR>", { desc = "[N]otifications", })
    end,
  },
}
