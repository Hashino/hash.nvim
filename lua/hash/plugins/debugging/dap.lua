return {
  'mfussenegger/nvim-dap',
  opts = {},
  config = function()
    require 'hash.plugins.debugging.adapters.gdb'
  end,
}
