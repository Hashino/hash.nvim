return {
  {
    "shortcuts/no-neck-pain.nvim",
    lazy = false,
    config = function()
      require("no-neck-pain").setup({
        width = 120,
        buffers = { bo = { filetype = "no-neck-pain", }, },

        disableOnLastBuffer = false,
        killAllBuffersOnDisable = true,

        autocmds = {
          enableOnVimEnter = true,
          enableOnTabEnter = true,
          skipEnteringNoNeckPainBuffer = true,
        },

        mappings = { enabled = false, },
      })
      vim.keymap.set("n", "<leader>c", require("no-neck-pain").toggle,
        { desc = "[C]enter Buffers", }
      )
    end,
  },
}
