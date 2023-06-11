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

local plugins = {
  -- utility
  'nvim-lua/plenary.nvim',
  'MunifTanjim/nui.nvim',
  'nvim-tree/nvim-web-devicons',

  -- lsp
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'folke/trouble.nvim',
  { 'folke/neoconf.nvim', cmd = 'Neoconf' },
  'folke/neodev.nvim',
  'jose-elias-alvarez/null-ls.nvim',

  -- snippet engine
  {
    'L3MON4D3/LuaSnip',
    build = 'make install_jsregexp LUAJIT_OSX_PATH=/opt/local'
  },

  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
  },

  -- completion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    lazy = true,
  },

  -- treesitter
  'nvim-treesitter/nvim-treesitter',
  {
    'nvim-treesitter/playground',
    cmd = 'TSPlaygroundToggle',
  },

  -- telescope
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
    },
  },

  -- filesystem tree
  'nvim-neo-tree/neo-tree.nvim',

  -- git
  {
    'airblade/vim-gitgutter',
    lazy = false,
  },
  {
    'sindrets/diffview.nvim',
    cmd = 'DiffviewOpen',
  },


  -- theme
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    init = function() require('core.theme') end,
  },

  -- other
  'nvim-lualine/lualine.nvim',
  'akinsho/bufferline.nvim',
  'numToStr/Comment.nvim',
  'folke/todo-comments.nvim',
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
  },
  {
    'moll/vim-bbye',
    cmd = { 'Bdelete', 'Bwipeout' },
  },

  -- syntax highlighting
  {
    'ARM9/arm-syntax-vim',
    filetype = 'armv4',
  },
}

local host_plugins = require('util.host').plugins
if host_plugins then
  for _, plugin in ipairs(host_plugins) do
    table.insert(plugins, plugin)
  end
end

lazy.setup(plugins, {
  defaults = {
    lazy = true,
  }
})
