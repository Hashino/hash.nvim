return {
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    config = function()
      require("nvim-treesitter.install").prefer_git = true

      require("nvim-treesitter.configs").setup({
        sync_install = true,

        modules = {},
        ignore_install = {},

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

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },

        auto_install = true, -- Autoinstall languages that are not installed yet

        disable = function(_, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      })
    end,
  },

  { -- TODO: find/make equivalent in lua
    "Yggdroot/hiPairs",
    config = function()
      vim.g.hiPairs_hl_matchPair = { term = "bold", gui = "bold", }
      vim.g.hiPairs_hl_unmatchPair = { term = "NONE", gui = "NONE", }
    end,
  },
}
