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
            search_down = {
              title = "",
            },
            search_up = {
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
          },
        },

        messages = {
          view = "mini",
          view_search = "mini",
        },

        routes = {
          {
            filter = {
              event = "lsp",
              kind = "progress",
            },
            view = "mini",
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
          {
            filter = {
              event = "msg_show",
              any = {
                { kind = "echo", },
                { kind = "bufwrite", },
                { find = "fewer lines", },
                { find = "after #", },
                { find = "before #", },
                { find = "No lines in buffer", },
                { find = "Found a swap file", },
                { find = "Ignoring swapfile", },
              },
            },
            skip = true,
          },
        },
      })

      vim.keymap.set("n", "<leader>N", function()
        require("noice").cmd("history")
      end, { desc = "Open [N]otifications", })
    end,
  },
}
