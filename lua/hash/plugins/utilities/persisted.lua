return {
  'olimorris/persisted.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  lazy = false, -- make sure the plugin is always loaded at startup
  config = function()
    require('persisted').setup {
      save_dir = vim.fn.expand(vim.fn.stdpath 'data' .. '/sessions/'), -- directory where session files are saved
      silent = true, -- silent nvim message when sourcing session file
      autosave = true, -- automatically save session files when exiting Neovim

      -- don't save session when in the alpha greeter window
      should_autosave = function()
        if vim.bo.filetype == 'alpha' or vim.fn.getcwd() == vim.fn.expand("$HOME") then
          return false
        else
          return true
        end
      end,
    }

    require('telescope').load_extension 'persisted'
    vim.keymap.set('n', '<C-s>', '<cmd>Telescope persisted<cr>', { desc = '[S]earch [C]ommands' })

    -- stops barbar from giving errors on session load
    vim.opt.sessionoptions:append 'globals'
    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = 'PersistedSavePre',
      group = vim.api.nvim_create_augroup('PersistedHooks', {}),
      callback = function()
        vim.api.nvim_exec_autocmds('User', { pattern = 'SessionSavePre' })
      end,
    })
  end,
}
