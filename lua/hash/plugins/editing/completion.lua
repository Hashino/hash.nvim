vim.pack.add({
  "https://github.com/saghen/blink.cmp",
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/zbirenbaum/copilot.lua",
}, { confirm = false, })

require("luasnip.loaders.from_vscode").lazy_load()

require("lazydev").setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv", }, },
  },
})

require("blink.cmp").setup({
  enabled = function()
    return not (
      vim.tbl_contains({}, vim.bo.filetype)
      or vim.bo.buftype == "nofile"
      or vim.bo.buftype == "prompt"
      or vim.b.completion == false
    )
  end,

  fuzzy = {
    implementation = "lua",
  },

  completion = {
    menu = {
      draw = {
        columns = {
          { "kind_icon", },
          { "label",       "label_description", },
          { "kind", },
          { "source_name", },
        },
      },
    },

    documentation = {
      auto_show = true,
    },
  },

  snippets = { preset = "luasnip", },

  sources = {
    default = {
      "lazydev",
      "lsp",
      "snippets",
      "path",
    },

    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
    },
  },

  keymap = {
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback", },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback", },

    ["<Enter>"] = { "accept", "fallback", },

    ["<A-l>"] = { "snippet_forward", },
    ["<A-h>"] = { "snippet_backward", },

    ["<C- >"] = { "show", "hide", },

    ["<C-d>"] = { "show_documentation", "hide_documentation", },
  },

  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "normal",
    kind_icons = require("hash.plugins.theme").kinds,
  },
})

require("copilot").setup({
  panel = { enabled = false, },

  suggestion = {
    auto_trigger = true,
    keymap = {
      accept = "<C-Enter>",
      next = "<C-n>",
      prev = "<C-p>",
    },
  },
})

vim.keymap.set("n", "<leader>C", function()
  if require("copilot.client").buf_is_attached(0) then
    require("copilot.command").disable()
  else
    require("copilot.command").enable()
  end
end, { desc = "Toggle [C]opilot", })
