return { -- Autocompletion
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
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
      "onsails/lspkind.nvim",
      init = function()
        -- setup() is also available as an alias
        require("lspkind").init({
          -- defines how annotations are shown default: symbol
          -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
          mode = "symbol_text",

          -- can be either 'default' (requires nerd-fonts font) or
          -- 'codicons' for codicon preset (requires vscode-codicons font)
          preset = "default",

          symbol_map = {
            Text          = "󰉿",
            Method        = "󰆧",
            Function      = "󰊕",
            Constructor   = "",
            Field         = "󰜢",
            Variable      = "󰀫",
            Class         = "󰠱",
            Interface     = "",
            Module        = "",
            Property      = "󰜢",
            Unit          = "󰑭",
            Value         = "󰎠",
            Enum          = "",
            Keyword       = "󰌋",
            Snippet       = "",
            Color         = "󰏘",
            File          = "󰈙",
            Reference     = "󰈇",
            Folder        = "󰉋",
            EnumMember    = "",
            Constant      = "󰏿",
            Struct        = "󰙅",
            Event         = "",
            Operator      = "󰆕",
            TypeParameter = "",
          },
        })
      end,
    },
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
  },
  config = function()
    -- See `:help cmp`
    local cmp = require("cmp")

    cmp.setup({
      snippet = {
        expand = function(args)
          vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
          -- luasnip.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = "menu,menuone,noinsert", },
      -- fancy icons
      window = {
        completion = {
          col_offset = -3,
          side_padding = 0,
        },
      },
      formatting = {
        fields = { "kind", "abbr", "menu", },
        format = function(entry, vim_item)
          local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50, })(entry,
            vim_item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true, })
          kind.kind = " " .. (strings[1] or "") .. " "
          kind.menu = "    (" .. (strings[2] or "") .. ")"

          return kind
        end,
      },

      mapping = cmp.mapping.preset.insert({

        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<Enter>"] = cmp.mapping.confirm({ select = true, }),
        ["<C-Space>"] = cmp.mapping.close(),

        -- <A-h/l> will move you to the next/previous expansion location.
        ["<A-l>"] = cmp.mapping(function() vim.snippet.jump(1) end, { "i", "s", }),
        ["<A-h>"] = cmp.mapping(function() vim.snippet.jump(-1) end, { "i", "s", }),
      }),
      sources = {
        { name = "nvim_lsp", },
        { name = "luasnip", },
        { name = "path", },
      },
    })
  end,
}
