vim.g.mapleader = ' '

local opts = { noremap = true, silent = true }

-- buffer navigation
vim.keymap.set('n', '<Tab>', vim.cmd.BufferLineCycleNext, opts)
vim.keymap.set('n', '<S-Tab>', vim.cmd.BufferLineCyclePrev, opts)

vim.keymap.set('n', '<S-l>', vim.cmd.BufferLineMoveNext, opts)
vim.keymap.set('n', '<S-h>', vim.cmd.BufferLineMovePrev, opts)

vim.keymap.set('n', '<leader>p', vim.cmd.BufferLineTogglePin, opts)

-- telescope
vim.keymap.set('n', '<leader>f', function(...) require('telescope.builtin').find_files(...) end, opts)
vim.keymap.set('n', '<leader><S-f>', function(...) require('telescope.builtin').live_grep(...) end, opts)
vim.keymap.set('n', '<leader>b', function(...) require('telescope.builtin').buffers(...) end, opts)

-- nvim-tree
vim.keymap.set('n', '<C-n>', '<cmd>Neotree filesystem toggle left<cr>', opts)

-- trouble
vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>', opts)
vim.keymap.set('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', opts)
vim.keymap.set('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', opts)

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
