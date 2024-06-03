return { -- Tabline with nvim-tree native support
  'romgrk/barbar.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  init = function()
    require('barbar').setup {
      animation = false, -- Enable/disable animations

      icons = {
        button = '',
        buffer_index = false,
      },
      no_name_title = '[New File]',

      sidebar_filetypes = {
        ['no-neck-pain'] = { event = 'BufWinLeave', text = '', align = 'left' },
        -- ['no-neck-pain'] = { event = 'BufWinLeave', text = '', align = 'right' },
        -- Trouble = { event = 'BufWinLeave', text = 'symbols-outline', align = 'right' },
        -- NvimTree = true
      }, -- filetypes that barbar will offset
    }
    -- nvimtree autosession workaround
    -- vim.g.barbar_auto_setup = false
    -- Buffer Navigation
    vim.keymap.set('n', '<tab>', '<Cmd>BufferNext<CR>')
    vim.keymap.set('n', '<S-tab>', '<Cmd>BufferPrevious<CR>')
    vim.keymap.set('n', '<A-c>', '<Cmd>BufferClose<CR>')

    -- Goto buffer in position...
    vim.api.nvim_set_keymap('n', '<A-1>', '<Cmd>BufferGoto 1<CR>',
      { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<A-2>', '<Cmd>BufferGoto 2<CR>',
      { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<A-3>', '<Cmd>BufferGoto 3<CR>',
      { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<A-4>', '<Cmd>BufferGoto 4<CR>',
      { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<A-5>', '<Cmd>BufferGoto 5<CR>',
      { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<A-6>', '<Cmd>BufferGoto 6<CR>',
      { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<A-7>', '<Cmd>BufferGoto 7<CR>',
      { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<A-8>', '<Cmd>BufferGoto 8<CR>',
      { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<A-9>', '<Cmd>BufferGoto 9<CR>',
      { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<A-0>', '<Cmd>BufferLast<CR>',
      { noremap = true, silent = true })
    -- Pin/unpin buffer
    vim.api.nvim_set_keymap('n', '<A-p>', '<Cmd>BufferPin<CR>',
      { noremap = true, silent = true })
    -- Close buffer
    vim.api.nvim_set_keymap('n', '<A-S-c>', '<Cmd>BufferCloseAllButCurrent<CR>',
      { noremap = true, silent = true })
  end,
  version = '^1.0.0', -- optional: only update when a new 1.x version is released
}
