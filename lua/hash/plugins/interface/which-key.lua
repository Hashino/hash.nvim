return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = {
      { "<leader>t", group = "[T]rouble", icon = { icon = '󱖫', color = "green" } },
      { "<leader>s", group = "[S]earch", icon = { icon = '', color = "grey" } },
      { "<leader>d", group = "To[D]o Actions", icon = { icon = '', color = "orange" } },
      { "<leader>g", group = "[G]it", icon = { icon = '', color = "blue" } },
    },
  }
}
