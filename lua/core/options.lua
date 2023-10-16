-- encoding
vim.opt.fileencoding = 'utf-8'
vim.opt.spelllang = 'en'

-- line handling
vim.opt.relativenumber = true
vim.opt.colorcolumn = '80'
vim.opt.scrolloff = 8
vim.opt.wrap = false

-- file backups
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true

-- indents
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- other
vim.opt.termguicolors = true

vim.opt.mouse = ''
vim.opt.shortmess = 'IF'

vim.opt.listchars = {
  eol = '¬',
  tab = '▸ ',
  trail = '×',
}

-- set update time for lsp hover
vim.opt.updatetime = 300
