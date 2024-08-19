return { -- bunch of lsp related utility plugins

  -- show notifications in bottom right corner
  { "j-hui/fidget.nvim", opts = {}, },

  { -- used for completion, annotations and signatures of Neovim apis
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    opts = {},
    config = function()
      require('lsp_signature').setup { hint_enable = false, }
    end,
  },

  { -- lsp inside nvim configuration
    "folke/lazydev.nvim",
    ft = "lua",
    dependencies = {
      "Bilal2453/luvit-meta",
      { -- optional completion source
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
          opts.sources = opts.sources or {}
          table.insert(opts.sources, {
            name = "lazydev",
            group_index = 0, -- skip loading LuaLS completions
          })
        end,
      },
    },
    opts = { library = { "luvit-meta/library", }, },
  },

  { -- preview of lsp actions
    "aznhe21/actions-preview.nvim",
    config = function()
      vim.keymap.set({ "v", "n" }, "<leader>q",
        require("actions-preview").code_actions,
        { desc = 'Apply [Q]uickfix' })
    end,
  }
}
