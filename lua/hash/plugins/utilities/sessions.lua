return {
  'olimorris/persisted.nvim',
  lazy = false, -- make sure the plugin is always loaded at startup
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

    -- fixes weird behaviours of no-neck-pain scratch buffers on save/load
    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = 'PersistedSavePre',
      callback = function()
        pcall(require("no-neck-pain").disable)
      end,
    })
    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = 'PersistedLoadPost',
      callback = function()
        pcall(require("no-neck-pain").enable)
      end,
    })
  end,
}
