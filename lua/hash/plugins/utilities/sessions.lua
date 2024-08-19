return {
  'olimorris/persisted.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim', 'shortcuts/no-neck-pain.nvim' },
  -- lazy = false, -- make sure the plugin is always loaded at startup
  config = function()
    require('persisted').setup {
      -- directory where session files are saved
      save_dir = vim.fn.expand(vim.fn.stdpath 'data' .. '/sessions/'),

      silent = true,   -- silent nvim message when sourcing session file
      autosave = true, -- automatically save session files when exiting Neovim

      -- don't save session when in the alpha greeter window or home dir
      should_autosave = function()
        return not (
          vim.bo.filetype == 'alpha' or
          vim.fn.getcwd() == vim.fn.expand '$HOME'
        )
      end,
    }

    local hook_group = vim.api.nvim_create_augroup('PersistedHooks', {})

    -- stops barbar from giving errors on session load
    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = 'PersistedSavePre',
      group = hook_group,
      callback = function()
        vim.api.nvim_exec_autocmds('User', { pattern = 'SessionSavePre' })
      end,
    })

    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = 'PersistedSavePre',
      group = hook_group,
      callback = function()
        require("no-neck-pain").disable()
      end,
    })
    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = 'PersistedLoadPost',
      group = hook_group,
      callback = function()
        --re enables the centering of buffers
        require("no-neck-pain").enable()
      end,
    })
  end,
}
