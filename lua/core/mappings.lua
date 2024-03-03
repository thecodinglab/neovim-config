vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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

-- highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
