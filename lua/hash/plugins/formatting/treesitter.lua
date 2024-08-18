return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  opts = {
    ensure_installed = {
      'lua',
      'c',
      'rust',
      'bash',
      'markdown',
      'markdown_inline',
      'vimdoc',
      'llvm',
      'gleam',
    },
    highlight = {
      enable = true
    },
    -- Autoinstall languages that are not installed
    auto_install = true,
  },
  config = function(_, opts)
    -- Prefer git instead of curl in order to improve connectivity in some environments
    require('nvim-treesitter.install').prefer_git = true
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup(opts)
  end,
}
