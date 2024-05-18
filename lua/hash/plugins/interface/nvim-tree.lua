return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local api = require 'nvim-tree.api'

    require('nvim-tree').setup {
      on_attach = function(bufnr)
        -- default mappings
        api.config.mappings.default_on_attach(bufnr)
      end,
      sync_root_with_cwd = false,
    }
  end,
}
