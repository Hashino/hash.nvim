return {
  "OXY2DEV/markview.nvim",
  lazy = false, -- Recommended
  -- ft = "markdown" -- If you decide to lazy-load anyway

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    local presets = require("markview.presets");

    require("markview").setup({
      headings = presets.headings.glow_labels,
      hybrid_modes = { "n" },
    })
  end
}
