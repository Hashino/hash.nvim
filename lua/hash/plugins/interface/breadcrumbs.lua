return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  event = "LspAttach",
  dependencies = { "SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons" },
  config = function()
    vim.opt.updatetime = 200
    require("barbecue").setup {
      create_autocmd = false,
      attach_navic = true,
      show_basename = false,
      show_dirname = false,
    }

    vim.api.nvim_create_autocmd({
        "WinResized", -- or WinResized on NVIM-v0.9 and higher
        "BufWinEnter",
        "CursorHold",
        "InsertLeave",
      },
      {
        group = vim.api.nvim_create_augroup("barbecue.updater", {}),
        callback = function()
          require("barbecue.ui").update()
        end,
      })
  end,
}
