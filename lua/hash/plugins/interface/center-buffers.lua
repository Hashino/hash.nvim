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
        killAllBuffersOnDisable = true,

        autocmds = {
          enableOnVimEnter = true,
          enableOnTabEnter = true,
        },

        mappings = { enabled = false, },
      })
      vim.keymap.set('n', '<leader>n', require'no-neck-pain'.toggle, { desc = "Toggle [N]oNeckPain" })
    end
  },
}
