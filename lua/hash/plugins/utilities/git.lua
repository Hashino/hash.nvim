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
        enabled = true,
        message_when_not_committed = "",
        message_template = "  <date> by [<author>] ⬪ <summary> ⬪ «<sha>»",
        date_format = "%b %d, %Y at %H:%M",
        virtual_text_column = 1,
        highlight_group = "GitBlame",
      })
    end,
  },
  {
    "sindrets/diffview.nvim",
    init = function()
      local actions = require("diffview.actions")
      require("diffview").setup({
        keymaps = {
          disable_defaults = false, -- Disable the default keymaps
          view = {
            { "n", "<leader>gco", actions.conflict_choose("ours"),
              { desc = "Choose the OURS version of a conflict", }, },
            { "n", "<leader>gct", actions.conflict_choose("theirs"),
              { desc = "Choose the THEIRS version of a conflict", }, },
            { "n", "<leader>gcb", actions.conflict_choose("base"),
              { desc = "Choose the BASE version of a conflict", }, },
            { "n", "<leader>gca", actions.conflict_choose("all"),
              { desc = "Choose all the versions of a conflict", }, },
            { "n", "<leader>gcO", actions.conflict_choose_all("ours"),
              { desc = "Choose the OURS version of a conflict for the whole file", }, },
            { "n", "<leader>gcT", actions.conflict_choose_all("theirs"),
              { desc = "Choose the THEIRS version of a conflict for the whole file", }, },
            { "n", "<leader>gcB", actions.conflict_choose_all("base"),
              { desc = "Choose the BASE version of a conflict for the whole file", }, },
            { "n", "<leader>gcA", actions.conflict_choose_all("all"),
              { desc = "Choose all the versions of a conflict for the whole file", }, },
            { "n", "dX", actions.conflict_choose_all("none"),
              { desc = "Delete the conflict region for the whole file", }, },
          },
          file_panel = {
            { "n", "?", actions.help("file_panel"),
              { desc = "Open the help panel", }, },
            { "n", "<leader>gcO", actions.conflict_choose_all("ours"),
              { desc = "Choose the OURS version of a conflict for the whole file", }, },
            { "n", "<leader>gcT", actions.conflict_choose_all("theirs"),
              { desc = "Choose the THEIRS version of a conflict for the whole file", }, },
            { "n", "<leader>gcB", actions.conflict_choose_all("base"),
              { desc = "Choose the BASE version of a conflict for the whole file", }, },
            { "n", "<leader>gcA", actions.conflict_choose_all("all"), { desc = "Choose all the versions of a conflict for the whole file", }, },
          },
          file_history_panel = {
            { "n", "?", actions.help("file_history_panel"),
              { desc = "Open the help panel", }, },
          },
          option_panel = {
            { "n", "?", actions.help("option_panel"),
              { desc = "Open the help panel", }, },
          },
        },
      })
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
