return { -- File explorer "<leader>e" to toggle
  'nvim-tree/nvim-tree.lua',
  version = '*',
  dependencies = { 'nvim-tree/nvim-web-devicons', },
  config = function()
    local api = require 'nvim-tree.api'

    local HEIGHT_RATIO = 0.8 -- You can change this
    local WIDTH_RATIO = 0.5  -- You can change this too

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
        vim.keymap.set('n', '<Enter>', api.tree.change_root_to_node,
          opts 'Change Directory')
        vim.keymap.set('n', '<BS>', api.tree.change_root_to_parent,
          opts 'Up a Directory')
        vim.keymap.set('n', '<Left>', api.node.navigate.parent_close,
          opts 'Close Directory')
        vim.keymap.set('n', 'h', api.node.navigate.parent_close,
          opts 'Close Directory')
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

      view = { -- configures floating
        float = {
          enable = true,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w = screen_w * WIDTH_RATIO
            local window_h = screen_h * HEIGHT_RATIO
            local window_w_int = math.floor(window_w)
            local window_h_int = math.floor(window_h)
            local center_x = (screen_w - window_w) / 2
            local center_y = ((vim.opt.lines:get() - window_h) / 2)
               - vim.opt.cmdheight:get()
            return {
              border = "rounded",
              relative = "editor",
              row = center_y,
              col = center_x,
              width = window_w_int,
              height = window_h_int,
            }
          end,
        },
        width = function()
          return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        end,
      },

      filters = { git_ignored = false, },

      git = { enable = true, },

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
