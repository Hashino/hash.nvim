return {
  'ray-x/lsp_signature.nvim',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('lsp_signature').setup {
      hint_prefix = '> ',
    }
  end,
}
