return {
  {
    "arnamak/stay-centered.nvim",
    config = function()
      require("stay-centered").setup({
        skip_filetypes = {},
        enabled = true,
        allow_scroll_move = false,
        disable_on_mouse = true,
      })
    end,
  },
  {
    "shortcuts/no-neck-pain.nvim",
    lazy = false,
    config = function()
      require("no-neck-pain").setup({
        width = 100,
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
