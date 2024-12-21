return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    config = true,
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
    init = function()
      local function git_cmd(cmd)
        return "<cmd>Git " .. cmd .. "<CR>"
      end

      vim.keymap.set("n", "<leader>gs", require("telescope.builtin").git_status,
        { desc = "[G]it [S]tatus", })

      vim.keymap.set("n", "<leader>gc", git_cmd("commit"),
        { desc = "[G]it [C]ommit", })

      vim.keymap.set("n", "<leader>gC", git_cmd("commit --amend"),
        { desc = "[G]it ammend [C]ommit", })

      vim.keymap.set("n", "<leader>gp", git_cmd("push"),
        { desc = "[G]it [P]ush", })

      vim.keymap.set("n", "<leader>gP", git_cmd("push --force"),
        { desc = "[G]it force [P]ush", })

      vim.keymap.set("n", "<leader>gl", git_cmd("log"),
        { desc = "[G]it [L]og", })

      vim.keymap.set("n", "<leader>gA", git_cmd("add ."),
        { desc = "[G]it [A]dd all", })
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
