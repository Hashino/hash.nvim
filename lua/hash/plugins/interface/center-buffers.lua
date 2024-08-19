return {
  {
    'shortcuts/no-neck-pain.nvim',
    lazy = false,
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
        },

        mappings = { enabled = false, },
      })
      vim.keymap.set('n', '<leader>np', require'no-neck-pain'.toggle, { desc = "Toggle [N]oNeck[P]ain" })
    end
  },
  {
    'Aasim-A/scrollEOF.nvim',
    event = { 'CursorMoved', 'WinScrolled' },
    opts = {},
  }
}
