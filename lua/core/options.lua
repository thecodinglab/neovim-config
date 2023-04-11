vim.opt.fileencoding = 'utf-8'

vim.opt.spelllang = 'en'

vim.opt.number = true
vim.opt.wrap = false

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true

vim.opt.termguicolors = true
vim.opt.colorcolumn = '80'

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.opt.mouse = 'a'
vim.opt.shortmess = 'IF'

vim.opt.listchars = {
  eol = '¬',
  tab = '▸ ',
  trail = '×',
}

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set update time for lsp hover
vim.opt.updatetime = 300
