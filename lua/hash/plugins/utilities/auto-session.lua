return {
  'rmagatti/auto-session',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('auto-session').setup {
      auto_session_root_dir = vim.fn.stdpath 'data' .. '/sessions/', -- Root dir where sessions will be stored

      log_level = vim.log.levels.ERROR,
      auto_session_enable_last_session = true,

      auto_session_enabled = true, -- Enables/disables auto creating, saving and restoring
      auto_session_create_enabled = true, -- Enables/disables auto creating new sessions
      auto_save_enabled = true, -- Enables/disables auto save feature
      auto_restore_enabled = true, -- Enables/disables auto restore feature

      auto_session_suppress_dirs = {
        '~',
      }, -- Suppress session restore/create in certain directories

      pre_save_cmds = {
        function()
          local nvimtree = require 'nvim-tree.view'
          if nvimtree.is_visible() then
            nvimtree.close()
          end
          vim.api.nvim_exec_autocmds('User', { pattern = 'SessionSavePre' })
        end,
      },

      post_restore_cmds = {
        function()
          -- require('auto-session').get_session_files
          require 'barbar'
          require('nvim-tree.api').tree.toggle { focus = false }
        end,
      },
    }

    vim.keymap.set('n', '<C-s>', require('auto-session.session-lens').search_session, {
      noremap = true,
    })
    -- -- Shows session picker automatically if neovim is running without arguments
    -- vim.api.nvim_create_autocmd('VimEnter', {
    --   callback = function()
    --     if vim.fn.argc() == 0 and vim.api.nvim_buf_get_name(0) == '' and vim.g.read_from_stdin == nil then
    --       require('auto-session.session-lens').search_session()
    --     end
    --   end,
    -- })
  end,
}
