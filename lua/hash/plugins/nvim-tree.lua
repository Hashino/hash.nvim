return { -- File Explorer - nvim-tree
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local api = require 'nvim-tree.api'

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

      actions = {
        change_dir = {
          global = true,
        },
      },

      view = { adaptive_size = true },

      git = {
        enable = true,
      },

      renderer = {
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
