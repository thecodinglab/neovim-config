vim.g.mapleader = ' '

local opts = { noremap = true, silent = true }

-- map escape to clear highlights in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>noh<cr>', opts)

-- indent while staying in visual mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- clipboard
vim.keymap.set('v', '<leader>y', '"+y', opts)
vim.keymap.set('n', '<leader>p', '"+p', opts)

-- save
vim.keymap.set('n', '<leader>w', '<cmd>silent write<cr>', opts)
