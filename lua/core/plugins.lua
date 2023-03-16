local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
  return
end

lazy.setup({
  -- utility
  'nvim-lua/plenary.nvim',
  'MunifTanjim/nui.nvim',
  'nvim-tree/nvim-web-devicons',

  -- lsp
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'folke/trouble.nvim',
  { 'folke/neoconf.nvim',  cmd = 'Neoconf' },
  'folke/neodev.nvim',

  -- snippet engine
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp"
  },

  -- completion
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'saadparwaiz1/cmp_luasnip',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',

  -- treesitter
  'nvim-treesitter/nvim-treesitter',
  'nvim-treesitter/playground',

  -- telescope
  'nvim-telescope/telescope.nvim',
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },

  -- filesystem tree
  'nvim-neo-tree/neo-tree.nvim',

  -- theme
  {
    'navarasu/onedark.nvim',
    init = function() require('core.theme') end,
    priority = 1000,
  },

  -- other
  'nvim-lualine/lualine.nvim',
  'akinsho/bufferline.nvim',
  'numToStr/Comment.nvim',
  'folke/todo-comments.nvim',
  'moll/vim-bbye',

  -- syntax highlighting
  { 'ARM9/arm-syntax-vim', filetype = 'armv4' }
})
