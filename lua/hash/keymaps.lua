
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>m', vim.diagnostic.open_float, { desc = 'Show diagnostic error [M]essages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Buffer Navigation
vim.keymap.set('n', '<tab>', '<Cmd>BufferNext<CR>', { desc = 'next buffer' })
vim.keymap.set('n', '<S-tab>', '<Cmd>BufferPrevious<CR>', { desc = 'previous buffer' })

-- :q Shortcut
vim.keymap.set('n', '<A-q>', '<Cmd>q<CR>', { desc = 'quick quit' })

-- Goto buffer in position...
vim.api.nvim_set_keymap('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-0>', '<Cmd>BufferLast<CR>', { noremap = true, silent = true })
-- Pin/unpin buffer
vim.api.nvim_set_keymap('n', '<A-p>', '<Cmd>BufferPin<CR>', { noremap = true, silent = true })
-- Close buffer
vim.api.nvim_set_keymap('n', '<A-c>', '<Cmd>BufferClose<CR>', { noremap = true, silent = true })
