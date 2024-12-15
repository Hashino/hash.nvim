return {
  {
    "saghen/blink.cmp",
    version = "v0.*",
    -- !Important! Make sure you're using the latest release of LuaSnip
    -- `main` does not work at the moment
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = (function()
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
        config = function()
          local ls = require("luasnip")

          -- in a lua file: search lua-, then c-, then all-snippets.
          ls.filetype_extend("lua", { "c", })
          -- in a cpp file: search c-snippets, then all-snippets only (no cpp-snippets!!).
          ls.filetype_set("cpp", { "c", })

          require("luasnip.loaders.from_lua").load({ include = { "c", }, })
          require("luasnip.loaders.from_lua").lazy_load({ include = { "all", "cpp", }, })
        end,
        dependencies = {
          {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end,
          },
        },
      },
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv", }, },
          },
        },
      },
      "mikavilpas/blink-ripgrep.nvim",
    },
    opts = {
      snippets = {
        expand = function(snippet) require("luasnip").lsp_expand(snippet) end,
        active = function(filter)
          if filter and filter.direction then
            return require("luasnip").jumpable(filter.direction)
          end
          return require("luasnip").in_snippet()
        end,
        jump = function(direction) require("luasnip").jump(direction) end,
      },

      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "luasnip",
          "ripgrep",
          "lazydev",
        },
      },

      providers = {
        lsp = { fallback_for = { "lazydev", }, },
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", },
        ripgrep = { module = "blink-ripgrep", },
      },

      keymap = {
        preset = "default",
        ["<S-Tab>"] = { "select_prev", "fallback", },
        ["<Tab>"] = { "select_next", "fallback", },

        ["<A-l>"] = { "snippet_forward", "fallback", },
        ["<A-h>"] = { "snippet_backward", "fallback", },

        ["<CR>"] = { "accept", "fallback", },

        -- show with a list of providers
        ["<C-Enter>"] = { function(cmp) cmp.show({ providers = { "snippets", }, }) end, },
        ["<C-Space>"] = { "hide", "fallback", },
      },

      completion = {
        menu = {
          draw = {
            treesitter = { "lsp", },
            columns = {
              { "kind_icon", },
              { "label",     "label_description", gap = 1, },
              { "kind", },
              { "source_name" }
            },
          },
        },
        list = {
          selection = "manual",
        },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",

        kind_icons = require("hash.plugins.theme").kinds,
      },
    },
  },
}
