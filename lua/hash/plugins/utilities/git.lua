return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  {
    "f-person/git-blame.nvim",
    -- load the plugin at startup
    event = "VeryLazy",
    -- Because of the keys part, you will be lazy loading this plugin.
    -- The plugin wil only load once one of the keys is used.
    -- If you want to load the plugin at startup, add something like event = "VeryLazy",
    -- or lazy = false. One of both options will work.
    opts = {
      enabled = true,
      message_when_not_committed = "",
      message_template = "[<date>] by [<author>] - <summary> |<sha>|",
      date_format = "%b %d, %Y at %H:%M",
      virtual_text_column = 1,
      highlight_group = "GitBlame",
    },
  },
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gs', require 'telescope.builtin'.git_status,
        { desc = '[G]it [S]tatus' })
      vim.keymap.set('n', '<leader>gc', '<cmd>Git commit<CR>',
        { desc = '[G]it [C]ommit' })
    end
  }
}
