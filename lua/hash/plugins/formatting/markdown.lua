return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  -- branch = "dev",

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local presets = require("markview.presets");

    require("markview").setup {
      hybrid_modes = { "n", },

      checkboxes = presets.checkboxes.nerd,
      headings = presets.headings.marker,
      horizontal_rules = presets.horizontal_rules.thin,
    }
  end,
}
