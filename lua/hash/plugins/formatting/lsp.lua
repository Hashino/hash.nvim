return {
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    config = function()
      local servers = {
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        clangd = {},
        rust_analyzer = {},
        lua_ls = {
          settings = {
            Lua = { -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = { globals = { 'vim', 'screen', 'awesome', 'root', 'client', 'tag' }
              },
            },
          },
        },
      }

      require'lspconfig'.gleam.setup{}

      vim.fn.sign_define('DiagnosticSignError',
        { text = '', texthl = 'DiagnosticSignError' })
      vim.fn.sign_define('DiagnosticSignWarn',
        { text = '', texthl = 'DiagnosticSignWarn' })
      vim.fn.sign_define('DiagnosticSignInfo',
        { text = '', texthl = 'DiagnosticSignInfo' })
      vim.fn.sign_define('DiagnosticSignHint',
        { text = '', texthl = 'DiagnosticSignHint' })

      vim.api.nvim_create_autocmd('LspAttach', {

        --  This function gets run when an LSP attaches to a particular buffer.
        callback = function(event)
          vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions,
            { buffer = event.buf, desc = 'LSP: [G]oto [D]efinition' })
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
            { buffer = event.buf, desc = 'LSP: [G]oto [D]eclaration' })
          vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references,
            { buffer = event.buf, desc = 'LSP: [G]oto [R]eferences' })
          vim.keymap.set('n', 'gI',
            require('telescope.builtin').lsp_implementations,
            { buffer = event.buf, desc = 'LSP: [G]oto [I]mplementation' })
          vim.keymap.set('n', '<leader>f', vim.lsp.buf.format,
            { buffer = event.buf, desc = 'LSP: [F]ormat buffer' })
          vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename,
            { buffer = event.buf, desc = 'LSP: [R]ename' })
          vim.keymap.set('n', "<leader>h", vim.lsp.buf.signature_help,
            { buffer = event.buf, desc = 'LSP: [H]elp' })
        end,
      })

      local capabilities = vim.tbl_deep_extend('force',
        vim.lsp.protocol.make_client_capabilities(),
        require('cmp_nvim_lsp').default_capabilities())

      require('mason').setup()
      -- Install all servers before configuring them
      require('mason-tool-installer').setup { ensure_installed = vim.tbl_keys(servers or {}) }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- overrides only values explicitly passed by the server configuration above.
            server.capabilities = vim.tbl_deep_extend('force', {},
              capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,

    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      --: Must be loaded before dependants
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    }
  },

  -- Utility Plugins

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
      vim.keymap.set({ "v", "n" }, "qa",
        require("actions-preview").code_actions,
        { desc = '[A]pply [Q]uickfix' })
    end,
  }
}
