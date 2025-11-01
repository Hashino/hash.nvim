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
                { "label",      "label_description", },
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
          ["<Tab>"] = { "select_next", "fallback", },
          ["<S-Tab>"] = { "select_prev", "fallback", },

          ["<Enter>"] = { "accept", "fallback", },

          ["<A-l>"] = { "snippet_forward", },
          ["<A-h>"] = { "snippet_backward", },

          ["<C- >"] = { "show", "hide", },

          ["<C-d>"] = { "show_documentation", "hide_documentation", },
        },

        appearance = {
          use_nvim_cmp_as_default = true,
          nerd_font_variant = "normal",
          kind_icons = require("hash.theme").kinds,
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
    init = function()
      vim.keymap.set("n", "<leader>C", function()
        if require("copilot.client").buf_is_attached(0) then
          require("copilot.command").disable()
        else
          require("copilot.command").enable()
        end
      end, { desc = "Toggle [C]opilot", })
    end,
  },
}
