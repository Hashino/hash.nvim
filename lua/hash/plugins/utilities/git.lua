return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+", },
        change = { text = "~", },
        delete = { text = "_", },
        topdelete = { text = "‾", },
        changedelete = { text = "≁", },
      },
    },
  },
  {
    "f-person/git-blame.nvim",
    -- load the plugin at startup
    event = "VeryLazy",
    -- Because of the keys part, you will be lazy loading this plugin.
    -- The plugin will only load once one of the keys is used.
    -- If you want to load the plugin at startup, add something like event = "VeryLazy",
    -- or lazy = false. One of both options will work.
    opts = {
      enabled = true,
      message_when_not_committed = "",
      message_template = "   <date> by [<author>] ⬪ <summary> ⬪ «<sha>»",
      date_format = "%b %d, %Y at %H:%M",
      virtual_text_column = 1,
      highlight_group = "GitBlame", -- defined in theme
    },
  },
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gs", require("telescope.builtin").git_status,
        { desc = "[G]it [S]tatus", })

      vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<CR>", { desc = "[G]it [C]ommit", })
      vim.keymap.set("n", "<leader>gp", "<cmd>Git push<CR>", { desc = "[G]it [P]ush", })
      vim.keymap.set("n", "<leader>gl", "<cmd>Git log<CR>", { desc = "[G]it [L]og", })
    end,
  },
  {
    "pwntester/octo.nvim",
    -- event = "VeryLazy",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      -- OR 'ibhagwan/fzf-lua',
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup({
        enable_builtin = true,
        default_to_projects_v2 = true,
      })

      vim.keymap.set("n", "<leader>gi", function()
        vim.cmd("Octo issue list")
      end, { desc = "[G]it [I]ssues", })
    end,
  },
}
