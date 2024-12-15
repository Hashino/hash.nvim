return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  event = "LspAttach",
  dependencies = { "SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons", },
  config = function()
    vim.opt.updatetime = 200
    require("barbecue").setup({
      create_autocmd = false,
      attach_navic = true,
      show_basename = false,
      show_dirname = false,

      kinds = require("hash.plugins.theme").kinds
    })

    vim.api.nvim_create_autocmd({
      "WinResized",
      "BufWinEnter",
      "CursorHold",
      "InsertLeave",
    }, {
      group = vim.api.nvim_create_augroup("barbecue.updater", {}),
      callback = function()
        require("barbecue.ui").update()
      end,
    })

    require("barbecue.ui").toggle() -- disabled by default
    vim.keymap.set("n", "<leader>B", require("barbecue.ui").toggle,
      { desc = "Toggle [B]readcrumbs", })
  end,
}
