return { -- LSP Configuration & Plugins
  "neovim/nvim-lspconfig",
  config = function()
    local servers = { -- See `:help lspconfig-all` for a list of all the pre-configured LSPs
      bashls = {},
      clangd = {},
      rust_analyzer = {},
      gopls = {},
      lua_ls = {
        settings = {
          Lua = { -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
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
          vim.tbl_extend("force", capabilities, {
            textDocument = {
              completion = {
                completionItem = {
                  snippetSupport = false,
                },
              },
            },
          })

          require("lspconfig")[server_name].setup({
            settings = server.settings or {},
            capabilities = vim.tbl_deep_extend("force", require("blink.cmp")
              .get_lsp_capabilities(capabilities), capabilities),

            on_attach = function(_, bufnr)
              vim.fn.sign_define("DiagnosticSignError",
                { text = "", texthl = "DiagnosticSignError", })
              vim.fn.sign_define("DiagnosticSignWarn",
                { text = "", texthl = "DiagnosticSignWarn", })
              vim.fn.sign_define("DiagnosticSignInfo",
                { text = "", texthl = "DiagnosticSignInfo", })
              vim.fn.sign_define("DiagnosticSignHint",
                { text = "", texthl = "DiagnosticSignHint", })

              local builtin = require("telescope.builtin")

              vim.keymap.set("n", "gd", builtin.lsp_definitions,
                { buffer = bufnr, desc = "LSP: [G]oto [D]efinition", })
              vim.keymap.set("n", "gD", vim.lsp.buf.declaration,
                { buffer = bufnr, desc = "LSP: [G]oto [D]eclaration", })
              vim.keymap.set("n", "gR", builtin.lsp_references,
                { buffer = bufnr, desc = "LSP: [G]oto [R]eferences", })
              vim.keymap.set("n", "gI", builtin.lsp_implementations,
                { buffer = bufnr, desc = "LSP: [G]oto [I]mplementation", })

              vim.keymap.set("n", "<leader>f", vim.lsp.buf.format,
                { buffer = bufnr, desc = "LSP: [F]ormat buffer", })
              vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename,
                { buffer = bufnr, desc = "LSP: [R]ename", })

              vim.keymap.set({ "v", "n", }, "<leader>q", vim.lsp.buf.code_action,
                { buffer = bufnr, desc = "LSP: [Q]uick Actions", })

              -- show diagnostics in floating window
              vim.api.nvim_create_autocmd("CursorHold", {
                buffer = bufnr,
                callback = require("tiny-inline-diagnostic").enable,
              })
            end,
          })
        end,
      },
    })
  end,

  dependencies = {
    { "williamboman/mason.nvim", config = true, },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    { -- preview of lsp actions
      "aznhe21/actions-preview.nvim",
      config = function()
        vim.lsp.buf.code_action = require("actions-preview").code_actions
      end,
    },
    {
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
