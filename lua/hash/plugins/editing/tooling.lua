vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  -- utilities
  "https://github.com/aznhe21/actions-preview.nvim",
  "https://github.com/MysticalDevil/inlay-hints.nvim",
  "https://github.com/rachartier/tiny-inline-diagnostic.nvim",
}, { confirm = false, })

local lsp_servers = {
  bashls = {},
  clangd = {},
  rust_analyzer = {},
  gopls = {},
  lua_ls = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file("lua", true),
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

-- disable snippets from lsp
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
      -- TODO: figure out the lsp mapping namespace
      --  why `gO` is outside the `gr*` mapping namespace? 🤔

      vim.keymap.set("n", "grd", vim.lsp.buf.definition,
        { buffer = bufnr, desc = "LSP: [G]oto [D]efinition", })

      vim.keymap.set("n", "<leader>f", vim.lsp.buf.format,
        { buffer = bufnr, desc = "LSP: [F]ormat Document", })

      -- auto format
      vim.api.nvim_create_autocmd("InsertLeave", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, })
        end,
      })

      -- code actions
      vim.lsp.buf.code_action = require("actions-preview").code_actions

      -- inlay hints
      require("inlay-hints").setup()

      vim.keymap.set("n", "<leader>I", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, { desc = "Toggle [I]nlay Hints", })

      vim.lsp.inlay_hint.enable(false) -- disable inlay hints by default

      -- inline diagnostics
      require("tiny-inline-diagnostic").setup({ preset = "minimal", })

      vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = require("tiny-inline-diagnostic").enable,
      })
    end,
  })
end
