return {
  {
    "shortcuts/no-neck-pain.nvim",
    lazy = true,
    keys = {
      { "<leader>c", function() require("no-neck-pain").toggle() end, desc = "Toggle [C]enter", },
    },
    config = function()
      require("no-neck-pain").setup({
        width = 96,
        buffers = {
          bo = {
            filetype = "no-neck-pain",
          },
        },

        disableOnLastBuffer = false,
        killAllBuffersOnDisable = true,

        autocmds = {
          enableOnVimEnter = true,
          enableOnTabEnter = true,
          skipEnteringNoNeckPainBuffer = true,
        },

        mappings = { enabled = false, },
      })
    end,
  },
}
