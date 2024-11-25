return {
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  "OXY2DEV/markview.nvim",
  lazy = false,
  branch = "dev",
  config = function()
    local presets = require("markview.presets");

    require("markview.spec").setup {
      hybrid_modes = { "n", },

      headings = presets.headings.marker,
      horizontal_rules = presets.horizontal_rules.thin,
    }
  end,
}
