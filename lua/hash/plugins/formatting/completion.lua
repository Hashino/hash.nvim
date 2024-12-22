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
            { path = "${3rd}/luv/library", words = { "vim%.uv", }, },
          },
        },
      },

      "mikavilpas/blink-ripgrep.nvim",
    },

    config = function()
      require("blink.cmp").setup({
        enabled = function()
          return not vim.tbl_contains({ "markdown", }, vim.bo.filetype)
             and vim.bo.buftype ~= "nofile"
             and vim.bo.buftype ~= "prompt"
             and vim.b.completion ~= false
        end,

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
            "lazydev",
            "lsp",
            "ripgrep",
            "path",
            "snippets",
            "buffer",
            "luasnip",
          },

          min_keyword_length = 1,

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
              opts = {
                search_casing = "--smart-case",
              },
            },
          },
        },

        keymap = {
          preset = "none",
          ["<Tab>"] = { "select_next", "fallback", },
          ["<S-Tab>"] = { "select_prev", "fallback", },

          ["<A-l>"] = { "snippet_forward", "fallback", },
          ["<A-h>"] = { "snippet_backward", "fallback", },

          ["<Enter>"] = { "accept", "fallback", },

          ["<C- >"] = { "show", "hide", },
        },

        completion = {
          menu = {
            draw = {
              treesitter = { "lsp", },
              columns = {
                { "kind_icon", },
                { "label",       "label_description", gap = 1, },
                { "kind", },
                { "source_name", },
              },
            },
          },
          trigger = {
            show_on_insert_on_trigger_character = false,
          },
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
          enabled = true,
          auto_trigger = true,
          hide_during_completion = true,
          debounce = 75,
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
