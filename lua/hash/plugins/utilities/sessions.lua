return {
  'olimorris/persisted.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
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

    require('telescope').load_extension 'persisted'
    vim.keymap.set('n', '<C-s>', '<cmd>Telescope persisted<cr>',
      { desc = '[S]earch [C]ommands' })

    local hook_group = vim.api.nvim_create_augroup('PersistedHooks', {})

    -- stops barbar from giving errors on session load
    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = 'PersistedSavePre',
      group = hook_group,
      callback = function()
        vim.api.nvim_exec_autocmds('User', { pattern = 'SessionSavePre' })
      end,
    })

    vim.opt.sessionoptions:append 'globals'
  end,
}
