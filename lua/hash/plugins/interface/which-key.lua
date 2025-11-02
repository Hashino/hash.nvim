return { -- Useful plugin to show you pending keybinds.
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons", },

  config = function()
    require("which-key").setup({
      sort = { "local", "group", "desc", },
      preset = "modern",
      spec = {
        { "<leader>d", group = "[D]oing", icon = { icon = "", color = "azure", }, },
        { "<leader>g", group = "[G]it", icon = { icon = "", color = "blue", }, },
        { "<leader>m", group = "[M]acros", icon = { icon = "󱖑", color = "red", }, },
        { "<leader>s", group = "[S]earch", icon = { icon = "", color = "grey", }, },
        { "<leader>t", group = "[T]rouble", icon = { icon = "󱖫", color = "yellow", }, },

        { "<leader>L", icon = "", },
        { "<leader>N", icon = "󰯋", },
        { "<leader>e", icon = "", },
        { "<leader>b", icon = "", },
      },
    })
  end,
}
