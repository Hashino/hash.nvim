return { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  config = function()
    local servers = {
      -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
      clangd = {},
      rust_analyzer = {},
      lua_ls = {
        settings = {
          Lua = {
            format = {
              enable = true,
              -- NOTE: values should be strings
              defaultConfig = {
                -- TODO: investigate why not working
                indent_style = "space",
                indent_size = "2",
                nax_line_length = "80",
              }
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            diagnostics = {
              globals = { 'vim', 'screen', 'awesome', 'root', 'client', 'tag' }
            },
          },
        },
      },
    }

    vim.api.nvim_create_autocmd('LspAttach', {

      group = vim.api.nvim_create_augroup('hash-lsp-attach', { clear = true }),

      --  This function gets run when an LSP attaches to a particular buffer.
      callback = function(event)
        local map_key = function(keys, func, desc)
          vim.keymap.set('n', keys, func,
            { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map_key('gd', require('telescope.builtin').lsp_definitions,
          '[G]oto [D]efinition')
        map_key('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map_key('gr', require('telescope.builtin').lsp_references,
          '[G]oto [R]eferences')
        map_key('gI', require('telescope.builtin').lsp_implementations,
          '[G]oto [I]mplementation')
        map_key('<leader>f', function() vim.lsp.buf.format({ async = true }) end,
          "[F]ormat buffer")
        map_key('<leader>r', vim.lsp.buf.rename, '[R]e[n]ame')
        map_key('<leader>ws',
          require('telescope.builtin').lsp_dynamic_workspace_symbols,
          '[W]orkspace [S]ymbols')

        local client = vim.lsp.get_client_by_id(
          event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_augroup = vim.api
             .nvim_create_augroup(
               'hash-lsp-highlight', { clear = false })

          -- highlights variable mentions on cursor hover
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf
               .document_highlight,
          })

          -- removes highlight once cursor moves
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf
               .clear_references,
          })

          -- removes highlights on lsp detach
          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('hash-lsp-detach',
              { clear = true }),

            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds
              { group = 'hash-lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        -- if client
        --    and client.server_capabilities.inlayHintProvider
        --    and vim.lsp.inlay_hint then
        --   map_key('<leader>th', function()
        --     vim.lsp.inlay_hint.enable(not vim.lsp
        --       .inlay_hint.is_enabled {})
        --   end, '[T]oggle Inlay [H]ints')
        -- end
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities = vim.tbl_deep_extend('force', capabilities,
      require('cmp_nvim_lsp').default_capabilities())

    require('mason').setup()

    -- Install all servers before configuring them
    require('mason-tool-installer').setup {
      ensure_installed = vim.tbl_keys(servers or {})
    }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}

          -- overrides only values explicitly passed
          -- by the server configuration above.
          server.capabilities = vim
             .tbl_deep_extend('force', {},
               capabilities,
               server.capabilities or {})

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

    -- Utility Plugins

    -- show notifications in bottom right corner
    { "j-hui/fidget.nvim",       opts = {}, },

    { -- used for completion, annotations and signatures of Neovim apis
      'ray-x/lsp_signature.nvim',
      event = 'VeryLazy',
      opts = {},
      config = function()
        require('lsp_signature')
           .setup { hint_prefix = '> ', }
      end,
    },
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      dependencies = { "Bilal2453/luvit-meta" },
      opts = { library = { "luvit-meta/library", }, },
    },
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
    { -- preview of lsp actions
      "aznhe21/actions-preview.nvim",
      config = function()
        vim.keymap.set({ "v", "n" }, "qa",
          require("actions-preview").code_actions,
          { desc = '[A]pply [Q]uickfix' })
      end,
    }
  },
}
