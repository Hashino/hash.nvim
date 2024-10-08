return { -- Fuzzy Finder (files, lsp, etc)
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      "nvim-telescope/telescope-fzf-native.nvim",

      build = "make",

      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim", },
  },
  config = function()
    local mappings = {
      ["<A-l>"] = require("telescope.actions").cycle_history_next,
      ["<A-h>"] = require("telescope.actions").cycle_history_prev,
      ["<C-j>"] = require("telescope.actions").preview_scrolling_down,
      ["<C-k>"] = require("telescope.actions").preview_scrolling_up,
      ["<Tab>"] = require("telescope.actions").move_selection_next,
      ["<S-Tab>"] = require("telescope.actions").move_selection_previous,
      ["<C- >"] = require("telescope.actions").toggle_selection,
      ["<C-a>"] = require("telescope.actions").git_staging_toggle,
      ["<A-S-q>"] = require("telescope.actions").add_selected_to_qflist,
      ["<A-q>"] = require("telescope.actions").close,
    }
    require("telescope").setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
        persisted = {
          layout_config = { width = 0.5, height = 0.7, },
        },
      },
      defaults = {
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        mappings = {
          n = mappings,
          i = mappings,
        },
        layout_config = {
          prompt_position = "top",
          height = 0.9,
          width = 0.75,
          preview_width = 80,
        },
      },
      pickers = {
        git_status = {
          mappings = {
            n = {
              ["<Tab>"] = require("telescope.actions").move_selection_next,
              ["<S-Tab>"] = require("telescope.actions").move_selection_previous,
              ["<C-a>"] = require("telescope.actions").git_staging_toggle,
            },
          },
        },
      },
    })
    -- Enable Telescope extensions if they are installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")

    -- See `:help telescope.builtin`
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader> ", builtin.commands, { desc = "[S]earch [C]ommands", })
    vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps", })
    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles", })
    vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers", })
    vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope", })
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord", })
    vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep", })
    vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume", })

    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp", })
    vim.keymap.set("n", "<leader>sm", builtin.man_pages, { desc = "[S]earch [M]anuals", })
  end,
}
