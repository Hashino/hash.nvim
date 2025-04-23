return { -- Persistent togglabe terminal "<A-t>" to toggle
  -- amongst your other plugins
  "akinsho/toggleterm.nvim",
  version = "*",
  init = function()
    require("toggleterm").setup({
      open_mapping = [[<A-t>]],
      size = 30,
      direction = "float",
      float_opts = { border = "rounded", },
    })
  end,
}
