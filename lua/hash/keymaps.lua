vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- for quick navigation between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- :q Shortcut
vim.keymap.set('n', '<A-q>', '<Cmd>q<CR>', { desc = 'quick quit' })

-- edit variable value
vim.keymap.set('n', '<leader>a', 'f=lC ', { desc = 'assign new value to variable' })
