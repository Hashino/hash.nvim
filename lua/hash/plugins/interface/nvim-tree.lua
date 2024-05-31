return { -- File explorer "<leader>e" to toggle
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local api = require 'nvim-tree.api'

    -- Restores NvimTree on session load
    vim.api.nvim_create_autocmd({ 'BufEnter' }, {
      pattern = 'NvimTree*',
      callback = function()
        local view = require 'nvim-tree.view'

        if not view.is_visible() then
          api.tree.open()
        end

        pcall(vim.api.nvim_command, 'doautocmd User SessionLoaded')
      end,
    })

    require('nvim-tree').setup {

      on_attach = function(bufnr)
        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings
        vim.keymap.set('n', '<Enter>', api.tree.change_root_to_node, opts 'Change Directory')
        vim.keymap.set('n', '<BS>', api.tree.change_root_to_parent, opts 'Up a Directory')
        vim.keymap.set('n', '<Left>', api.node.navigate.parent_close, opts 'Close Directory')
        vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts 'Close Directory')
        vim.keymap.set('n', '<Right>', api.node.open.edit, opts 'Open')
        vim.keymap.set('n', 'l', api.node.open.edit, opts 'Open')
        vim.keymap.set('n', '?', api.tree.toggle_help, opts 'Help')
      end,

      vim.keymap.set('n', '<leader>e', api.tree.toggle, { desc = 'Open/Close File [E]xplorer' }),

      diagnostics = {
        enable = true,
      },

      sync_root_with_cwd = true,
      actions = {
        change_dir = {
          global = true,
        },
      },

      view = { adaptive_size = true },

      filters = {
        git_ignored = false,
      },

      git = {
        enable = true,
      },

      renderer = {
        root_folder_label = false,
        highlight_git = true,
        icons = {
          show = {
            git = true,
          },
          glyphs = {
            default = '󰈚',
            symlink = '',
            folder = {
              default = '',
              empty = '',
              empty_open = '',
              open = '',
              symlink = '',
              symlink_open = '',
              arrow_open = '',
              arrow_closed = '',
            },
            git = {
              unstaged = '',
              staged = '',
              unmerged = '',
              renamed = '',
              untracked = '',
              deleted = '',
              ignored = '◌',
            },
          },
        },
      },
    }
  end,
}
