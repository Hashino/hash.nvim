return {
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- Prefer git instead of curl in order to improve connectivity in some environments
      require("nvim-treesitter.install").prefer_git = true
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "c",
          "rust",
          "bash",
          "html",
          "markdown",
          "markdown_inline",
          "vim",
          "vimdoc",
        },
        highlight = { enable = true, },
        auto_install = true, -- Autoinstall languages that are not installed
      })
    end,
  },
  {
    "Yggdroot/hiPairs",
    config = function()
      vim.cmd [[
        let g:hiPairs_hl_matchPair = { 'term'    : 'underline,bold',
                    \                  'cterm'   : 'bold',
                    \                  'gui'     : 'bold',
                    \ }
      ]]
    end,
  },
}
