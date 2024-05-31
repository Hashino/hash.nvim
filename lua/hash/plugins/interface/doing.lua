return {
  'hashino/doing.nvim',
  opts = {},
  config = function()
    require('doing').setup {
      -- default options
      message_timeout = 2000,
      doing_prefix = 'Doing: ',

      winbar = {
        enabled = true,
        ignored_buffers = { 'NvimTree' },
      },

      store = {
        auto_create_file = true,
        file_name = '.tasks',
      },
    }

    vim.keymap.set('n', '<leader>de', require('doing.core').edit, { desc = '[E]dit what tasks you`re [D]oing' })
    vim.keymap.set('n', '<leader>dn', require('doing.core').done, { desc = '[D]o[n]e with current task' })
  end,
}
