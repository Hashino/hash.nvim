return { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  config = function()
    local servers = { -- See `:help lspconfig-all` for a list of all the pre-configured LSPs
      clangd = {},
      rust_analyzer = {},
      lua_ls = {
        settings = {
          Lua = { -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            telemetry = { enable = false },
            diagnostics = {
              globals =
              {
                'vim',
                'screen',
                'awesome',
                'root',
                'client',
                'tag'
              },
              disable = {
                "missing-fields",
              }
            },
          },
        },
      },
    }

    require('mason').setup() -- Install all servers before configuring them
    require('mason-tool-installer').setup { ensure_installed = vim.tbl_keys(servers or {}) }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          local capabilities = vim.tbl_deep_extend(
            'force',
            {},
            vim.tbl_deep_extend(
              'force',
              vim.lsp.protocol.make_client_capabilities(),
              require('cmp_nvim_lsp').default_capabilities()
            ),
            server.capabilities or {}
          )

          -- overrides only values explicitly passed by the server configuration above.
          require('lspconfig')[server_name].setup({
            settings = server.settings or {},
            capabilities = capabilities,

            on_attach = function(client, bufnr)
              vim.fn.sign_define('DiagnosticSignError',
                { text = '', texthl = 'DiagnosticSignError' })
              vim.fn.sign_define('DiagnosticSignWarn',
                { text = '', texthl = 'DiagnosticSignWarn' })
              vim.fn.sign_define('DiagnosticSignInfo',
                { text = '', texthl = 'DiagnosticSignInfo' })
              vim.fn.sign_define('DiagnosticSignHint',
                { text = '', texthl = 'DiagnosticSignHint' })

              vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions,
                { buffer = bufnr, desc = 'LSP: [G]oto [D]efinition' })
              vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
                { buffer = bufnr, desc = 'LSP: [G]oto [D]eclaration' })
              vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references,
                { buffer = bufnr, desc = 'LSP: [G]oto [R]eferences' })
              vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations,
                { buffer = bufnr, desc = 'LSP: [G]oto [I]mplementation' })
              vim.keymap.set('n', '<leader>f', vim.lsp.buf.format,
                { buffer = bufnr, desc = 'LSP: [F]ormat buffer' })
              vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename,
                { buffer = bufnr, desc = 'LSP: [R]ename' })
              vim.keymap.set('n', "<leader>h", vim.lsp.buf.signature_help,
                { buffer = bufnr, desc = 'LSP: [H]elp' })
            end
          })
        end,
      },
    }
  end,

  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  }
}
