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

        mappings = { enabled = false, },
      })
      -- vim.keymap.set('n', '<leader>nnp', require 'no-neck-pain'.toggle, { desc = "Toggle [N]o[N]eck[P]ain" })
    end
  },
  {
    'Aasim-A/scrollEOF.nvim',
    event = { 'CursorMoved', 'WinScrolled' },
    opts = {},
  }
}
