vim.g.mapleader = ' '

local opts = { noremap = true, silent = true }

-- disable vim keyword search
vim.keymap.set('i', 'C-n', '<nop>', opts)

-- indent while staying in visual mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- clipboard
vim.keymap.set('v', '<leader>y', '"+y', opts)
vim.keymap.set('n', '<leader>p', '"+p', opts)

-- save
vim.keymap.set('n', '<leader>w', '<cmd>silent write<cr>', opts)

-- move lines
vim.keymap.set('n', '<A-j>', '<cmd>m .+1<cr>', opts)
vim.keymap.set('n', '<A-k>', '<cmd>m .-2<cr>', opts)

-- move cursor between wrapped lines instead of full lines
vim.keymap.set('n', 'j', 'gj', opts)
vim.keymap.set('n', 'k', 'gk', opts)

-- create scratch buffer
local function create_scratch()
  vim.cmd('enew')
  vim.bo.buftype = 'nofile'
  vim.bo.bufhidden = 'hide'
  vim.bo.swapfile = false
end

vim.keymap.set('n', '<leader>e', create_scratch, opts)
