return { -- LSP Configuration & Plugins
  "neovim/nvim-lspconfig",
  config = function()
    local servers = { -- See `:help lspconfig-all` for a list of all the pre-configured LSPs
      copilot = {},
      bashls = {},
      clangd = {},
      rust_analyzer = {},
      gopls = {},
      lua_ls = {
        settings = {
          Lua = { -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            hint = { enable = true, },
            telemetry = { enable = false, },
            diagnostics = {
              globals = { "vim", },
              disable = { "missing-fields", },
            },
          },
        },
      },
    }

    local mason_tools = vim.list_extend({
      "codelldb",
      "tree-sitter-cli",
    }, vim.tbl_keys(servers))

    require("mason").setup() -- Install all servers before configuring them
    require("mason-tool-installer").setup({ ensure_installed = mason_tools, })

    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          local capabilities = vim.lsp.protocol.make_client_capabilities()

          -- disable lsp snippets support, as we use luasnip
          vim.tbl_extend("force", capabilities, {
            textDocument = {
              completion = {
                completionItem = {
                  snippetSupport = false,
                },
              },
            },
          })

          vim.lsp.config(server_name, {
            settings = server.settings or {},
            capabilities = vim.tbl_deep_extend("force", require("blink.cmp")
              .get_lsp_capabilities(capabilities), capabilities),

            on_attach = function(_, bufnr)
              vim.lsp.inlay_hint.enable(false) -- disable inlay hints by default

              vim.keymap.set("n", "gd", vim.lsp.buf.definition,
                { buffer = bufnr, desc = "LSP: [G]oto [D]efinition", })

              vim.keymap.set("n", "<leader>f", vim.lsp.buf.format,
                { buffer = bufnr, desc = "LSP: [F]ormat Document", })

              vim.api.nvim_create_autocmd("InsertLeave", {
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format({ bufnr = bufnr, })
                end,
              })

              vim.api.nvim_create_autocmd("CursorHold", {
                buffer = bufnr,
                callback = require("tiny-inline-diagnostic").enable,
              })
            end,

          })

          vim.lsp.enable(server_name)
        end,
      },
    })
  end,

  dependencies = {
    {
      "williamboman/mason.nvim",
      config = true,
    },

    {
      "williamboman/mason-lspconfig.nvim",
    },

    "WhoIsSethDaniel/mason-tool-installer.nvim",

    { -- preview of lsp actions
      "aznhe21/actions-preview.nvim",
      config = function()
        vim.lsp.buf.code_action = require("actions-preview").code_actions
      end,
    },

    {
      "MysticalDevil/inlay-hints.nvim",
      event = "LspAttach",
      dependencies = { "neovim/nvim-lspconfig", },
      config = function()
        require("inlay-hints").setup()

        vim.keymap.set("n", "<leader>I", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, { desc = "Toggle [I]nlay Hints", })
      end,
    },

    { -- show inline diagnostics
      "rachartier/tiny-inline-diagnostic.nvim",
      event = "LspAttach",
      config = function()
        require("tiny-inline-diagnostic").setup({ preset = "minimal", })
        require("tiny-inline-diagnostic").disable()
        vim.diagnostic.config({ virtual_text = false, })
      end,
    },
  },
}
