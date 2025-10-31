return {
  { -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",

    dependencies = {
      {
        "williamboman/mason.nvim",
        config = true,
      },

      "williamboman/mason-lspconfig.nvim",         -- allows to use lspconfig names in mason
      "WhoIsSethDaniel/mason-tool-installer.nvim", -- auto installs predefined list of mason tools
    },

    config = function()
      local lsp_servers =
      {   -- See `:help lspconfig-all` for a list of all the pre-configured LSPs
        bashls = {},
        clangd = {},
        rust_analyzer = {},
        gopls = {},
        lua_ls = {
          settings = {
            Lua = {
              hint = { enable = true, },
              telemetry = { enable = false, },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
              },
            },
          },
        },
      }

      -- other mason tools we also want installed
      local tools = {
        "codelldb",
        "tree-sitter-cli",
      }

      require("mason").setup()
      require("mason-lspconfig").setup()
      require("mason-tool-installer").setup({
        ensure_installed = vim.list_extend(vim.tbl_keys(lsp_servers), tools),
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities({
        textDocument = {
          completion = {
            completionItem = {
              snippetSupport = false,
            },
          },
        },
      })

      for server, config in pairs(lsp_servers) do
        vim.lsp.config(server, {
          settings = config or {},
          capabilities = capabilities,

          on_attach = function(_, bufnr)
            vim.lsp.inlay_hint.enable(false) -- disable inlay hints by default

            vim.keymap.set( "n", "grd", vim.lsp.buf.definition,
              { buffer = bufnr, desc = "LSP: [G]oto [D]efinition", })

            vim.keymap.set( "n", "<leader>f", vim.lsp.buf.format,
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
      end
    end,
  },

  { -- preview of lsp actions
    "aznhe21/actions-preview.nvim",
    config = function()
      vim.lsp.buf.code_action = require("actions-preview").code_actions
    end,
  },

  { -- inlay hints configs
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
}
