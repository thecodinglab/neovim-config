vim.g.mapleader = ' '

local opts = { noremap = true, silent = true }

-- disable vim keyword search
vim.keymap.set('i', 'C-n', '<nop>', opts)

-- indentation & stay in visual mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- clipboard
vim.keymap.set('v', '<leader>y', '"+y', opts)
vim.keymap.set('n', '<leader>p', '"+p', opts)

-- save
vim.keymap.set('n', '<leader>w', '<cmd>silent write<cr>', opts)

-- create scratch buffer
local function create_scratch()
  vim.cmd('enew')
  vim.bo.buftype = 'nofile'
  vim.bo.bufhidden = 'hide'
  vim.bo.swapfile = false
end

vim.keymap.set('n', '<leader>e', create_scratch, opts)
