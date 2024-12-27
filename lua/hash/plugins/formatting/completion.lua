return {
  {
    "saghen/blink.cmp",
    version = "*",
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
          -- in a cpp file: search c-snippets, then all-snippets only
          ls.filetype_set("cpp", { "c", }) -- (no cpp-snippets)

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
            { path = "${3rd}/luv/library", words = { "vim%.uv", }, },
          },
        },
      },

      "mikavilpas/blink-ripgrep.nvim",
    },

    config = function()
      require("blink.cmp").setup({
        enabled = function()
          return not vim.tbl_contains({}, vim.bo.filetype)
             and vim.bo.buftype ~= "nofile"
             and vim.bo.buftype ~= "prompt"
             and vim.b.completion ~= false
        end,

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

          trigger = {
            show_on_trigger_character = true,
          },
        },

        sources = {
          min_keyword_length = 1,

          default = {
            "lazydev",
            "lsp",
            "ripgrep",
            "path",
            "luasnip",
          },

          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 100,
            },

            ripgrep = {
              name = "RipGrep",
              module = "blink-ripgrep",
              score_offset = -2,
              max_items = 3,
              opts = {
                prefix_min_len = 4,
                search_casing = "--smart-case",
              },
            },
          },
        },

        keymap = {
          ["<Tab>"] = { "select_next", "snippet_forward", "fallback", },
          ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback", },

          ["<Enter>"] = { "accept", "fallback", },

          ["<A-l>"] = {  "snippet_forward", "fallback", },
          ["<A-h>"] = {  "snippet_backward", "fallback", },

          ["<C- >"] = { "show", "hide", },

          ["<C-d>"] = { "show_documentation", "hide_documentation", },
        },

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

        appearance = {
          use_nvim_cmp_as_default = true,
          nerd_font_variant = "normal",
          kind_icons = require("hash.plugins.theme").kinds,
        },
      })
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
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
    end,
  },
}
