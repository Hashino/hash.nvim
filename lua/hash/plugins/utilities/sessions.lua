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
      should_save = function()
        return not (
          vim.bo.filetype == 'alpha' or
          vim.fn.getcwd() == vim.fn.expand '$HOME'
        )
      end,
    }

    -- prevents certain buffers from beings saved to session
    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = 'PersistedSavePre',
      callback = function()
        for _, buf in pairs(vim.api.nvim_list_bufs()) do
          for _, filetype in pairs({ "gitcommit", "octo" }) do
            if vim.bo[buf].filetype == filetype then
              vim.api.nvim_buf_delete(buf, { force = true })
              -- to bypass the "Press any key to continue" when exiting
              vim.api.nvim_feedkeys(' ', 'm', true)
            end
          end
        end
      end,
    })
  end,
}
