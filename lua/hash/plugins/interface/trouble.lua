return {
  'folke/trouble.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'folke/todo-comments.nvim',
  },

  config = function()
    local win_opts = {
      type = 'split',
      position = 'bottom',
      relative = 'win'
    }

    local api = require 'trouble.api'

    vim.keymap.set('n', '<leader>tw', function()
      api.toggle({ mode = 'diagnostics', win = win_opts })
    end, { desc = '[T]rouble: [W]orkspace Diagnostics' })

    vim.keymap.set('n', '<leader>td', function()
      api.toggle({ mode = 'diagnostics', filter = { buf = 0 }, win = win_opts })
    end, { desc = '[T]rouble: [D]ocument Diagnostics' })

    vim.keymap.set('n', '<leader>tn', function()
      api.toggle({ mode = 'todo', win = win_opts })
    end, { desc = '[T]rouble: [N]otes' })

    vim.keymap.set('n', '<leader>ts', function()
      api.toggle({ mode = 'symbols', win = win_opts })
    end, { desc = '[T]rouble: [S]ymbols' })

    require 'trouble'.setup {
      focus = true,
      win = win_opts,
      preview = {
        type = "main",
        scratch = true,
      },
    }
  end,
}
