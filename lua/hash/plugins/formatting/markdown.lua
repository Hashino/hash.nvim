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
      hybrid_modes = { "n" },

      horizontal_rules = {
        enable = true,

        parts = {
          {
            type = "repeating",
            text = "─",
            hl = "Note",

            repeat_amount = function()
              return vim.o.columns;
            end
          },
        }
      }
    })
  end
}
