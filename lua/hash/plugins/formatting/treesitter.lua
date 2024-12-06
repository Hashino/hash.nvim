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
          "regex",
          "markdown",
          "markdown_inline",
          "vim",
          "vimdoc",
          "latex",
        },
        highlight = { enable = true, },
        auto_install = true,            -- Autoinstall languages that are not installed

        disable = function(_, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
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
