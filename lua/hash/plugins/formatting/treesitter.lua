return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'lua',
        'c',
        'rust',
        'bash',
        'html',
        'markdown',
        'markdown_inline',
        'vim',
        'vimdoc',
      },
      highlight = { enable = true },
      auto_install = true, -- Autoinstall languages that are not installed
    },
    config = function(_, opts)
      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
