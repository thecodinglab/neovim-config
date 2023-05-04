vim.g.mapleader = ' '

local opts = { noremap = true, silent = true }

-- buffer navigation
vim.keymap.set('n', '<Tab>', vim.cmd.BufferLineCycleNext, opts)
vim.keymap.set('n', '<S-Tab>', vim.cmd.BufferLineCyclePrev, opts)

vim.keymap.set('n', '<S-l>', vim.cmd.BufferLineMoveNext, opts)
vim.keymap.set('n', '<S-h>', vim.cmd.BufferLineMovePrev, opts)

vim.keymap.set('n', '<leader>p', vim.cmd.BufferLineTogglePin, opts)

-- lsp


-- telescope
local status_ok, telescope = pcall(require, 'telescope.builtin')
if status_ok then
  vim.keymap.set('n', '<leader>f', telescope.find_files, opts)
  vim.keymap.set('n', '<leader><S-f>', telescope.live_grep, opts)
  vim.keymap.set('n', '<leader>b', telescope.buffers, opts)
end

-- nvim-tree
vim.keymap.set('n', '<C-n>', vim.cmd.NeoTreeRevealToggle, opts)

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
