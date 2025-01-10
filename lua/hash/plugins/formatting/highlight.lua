return {
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim", },

    config = function()
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

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },

        auto_install = true, -- Autoinstall languages that are not installed

        disable = function(_, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall((vim.loop or vim.uv).fs_stat,
            vim.api.nvim_buf_get_name(buf))
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
