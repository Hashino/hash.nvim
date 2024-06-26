return {
  {
    'shortcuts/no-neck-pain.nvim',
    config = function()
      require("no-neck-pain").setup({

        width = 120,
        buffers = { bo = { filetype = "no-neck-pain", } },

        -- minSideBufferWidth = 0,
        disableOnLastBuffer = false,
        killAllBuffersOnDisable = false,

        autocmds = {
          enableOnVimEnter = true,
          enableOnTabEnter = true,
          -- skipEnteringNoNeckPainBuffer = true,
        },

        mappings = {
          enabled = true,
          toggle = "<Leader>nnp",
          toggleLeftSide = "<Leader>npl",
          toggleRightSide = "<Leader>npr",
          widthUp = "<Leader>n=",
          widthDown = "<Leader>n-",
          scratchPad = "<Leader>ns",
        },
      })
    end
  },
  {
    'Aasim-A/scrollEOF.nvim',
    event = { 'CursorMoved', 'WinScrolled' },
    opts = {},
  }
}
