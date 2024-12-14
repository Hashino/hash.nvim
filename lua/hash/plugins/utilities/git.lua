return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    opts = {
      -- signs = {
      --   add = { text = "+", },
      --   change = { text = "~", },
      --   delete = { text = "_", },
      --   topdelete = { text = "‾", },
      --   changedelete = { text = "≁", },
      -- },
    },
    init = function()
      local gitsigns = require("gitsigns")
      vim.keymap.set("n", "<leader>gS", gitsigns.toggle_signs,
        { desc = "[G]it [S]igns", })
      -- disables on startup
      gitsigns.toggle_signs()
    end,
  },
  {
    "f-person/git-blame.nvim",
    dependencies = { "rmehri01/onenord.nvim", },
    config = function()
      -- sets highlight for the virtual text
      local colors = require("onenord.colors").load()
      require("onenord.util").highlight("GitBlame", {
        fg    = colors.gray,
        bg    = "#353B49",
        style = "italic",
      })

      require("gitblame").setup({
        enabled = false,
        message_when_not_committed = "",
        message_template = "  <date> by [<author>] ⬪ <summary> ⬪ «<sha>»",
        date_format = "%b %d, %Y at %H:%M",
        virtual_text_column = 1,
        highlight_group = "GitBlame",
      })
      vim.keymap.set("n", "<leader>gB", require("gitblame").toggle,
        { desc = "[G]it [B]lame", })
    end,
  },
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gs", require("telescope.builtin").git_status,
        { desc = "[G]it [S]tatus", })
      vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<CR>",
        { desc = "[G]it [C]ommit", })
      vim.keymap.set("n", "<leader>gC", "<cmd>Git commit --amend<CR>",
        { desc = "[G]it ammend [C]ommit", })
      vim.keymap.set("n", "<leader>gp", "<cmd>Git push<CR>",
        { desc = "[G]it [P]ush", })
      vim.keymap.set("n", "<leader>gP", "<cmd>Git push --force<CR>",
        { desc = "[G]it force [P]ush", })
      vim.keymap.set("n", "<leader>gl", "<cmd>Git log<CR>",
        { desc = "[G]it [L]og", })
    end,
  },
  {
    "pwntester/octo.nvim",
    event = "VeryLazy",
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
