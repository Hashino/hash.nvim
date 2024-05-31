return {
  'mfussenegger/nvim-dap',
  init = function()
    require 'hash.plugins.debugging.adapters.gdb'
  end,
}
