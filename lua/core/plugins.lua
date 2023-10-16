local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  -- clone lazy if not already exists
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

local project_status_ok, project_plugins = pcall(require, 'project.plugins')
if not project_status_ok then
  project_plugins = {}
end

local plugins = {
  -- utility
  'nvim-lua/plenary.nvim',
  'MunifTanjim/nui.nvim',
  'nvim-tree/nvim-web-devicons',

  -- lsp
  {
    'neovim/nvim-lspconfig',
    -- TODO: can this be done on-demand (lazy)?
    lazy = false,
  },
  {
    'williamboman/mason.nvim',
    -- TODO: can this be done on-demand (lazy)?
    lazy = false,
    cmd = {
      'Mason',
      'MasonInstall',
      'MasonInstallAll',
      'MasonUninstall',
      'MasonUninstallAll',
      'MasonLog',
    },
    dependencies = {
      -- TODO: where to move this?
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      local opts = require('config.lsp.mason')
      require('mason').setup(opts.mason)
      require('mason-lspconfig').setup(opts.mason_lspconfig)

      require('core.lsp.server').setup()
    end,
  },
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble', 'TroubleToggle' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  'folke/neodev.nvim',

  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    opts = require('config.copilot'),
  },

  -- completion
  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        -- NOTE: fix to make it possible to use on macos with macports
        build = 'make install_jsregexp LUAJIT_OSX_PATH=/opt/local',
        dependencies = { 'rafamadriz/friendly-snippets' },
        config = require('config.luasnip').config
      },

      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    opts = function()
      return require('config.cmp')
    end,
  },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufRead', 'BufWinEnter', 'BufNewFile' },
    main = 'nvim-treesitter.configs',
    opts = require('config.treesitter'),
  },
  {
    'nvim-treesitter/playground',
    cmd = 'TSPlaygroundToggle',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    }
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
    cmd = 'Telescope',
    opts = require('config.telescope'),
    config = function(_, opts)
      local telescope = require('telescope')

      telescope.setup(opts)
      telescope.load_extension('fzf')
    end,
  },

  -- filesystem tree
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    main = 'neo-tree',
    opts = require('config.neo-tree'),
  },

  -- git
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufRead', 'BufWinEnter', 'BufNewFile' },
    opts = require('config.gitsigns'),
  },
  {
    'sindrets/diffview.nvim',
    cmd = 'DiffviewOpen',
  },


  -- theme
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    init = function()
      require('core.theme').setup()
    end,
  },

  -- comments
  {
    'numToStr/Comment.nvim',
    keys = {
      { vim.g.mapleader .. '/',  mode = 'n' },
      { vim.g.mapleader .. 'b/', mode = 'n' },
      { vim.g.mapleader .. '/',  mode = 'v' },
      { vim.g.mapleader .. 'b/', mode = 'v' },
    },
    opts = require('config.comment'),
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = { 'BufRead', 'BufWinEnter', 'BufNewFile' },
    opts = require('config.todo-comments'),
  },

  -- other
  {
    'nvim-lualine/lualine.nvim',
    opts = require('config.lualine'),
    -- TODO: can this be done on-demand (lazy)?
    lazy = false,
  },
  {
    'akinsho/bufferline.nvim',
    opts = require('config.bufferline'),
    -- TODO: can this be done on-demand (lazy)?
    lazy = false,
  },
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
  },
  {
    'moll/vim-bbye',
    cmd = { 'Bdelete', 'Bwipeout' },
  },
  {
    'aserowy/tmux.nvim',
    -- TODO: can this be done on-demand (lazy)?
    lazy = false,
    opts = {
      navigation = {
        cycle_navigation = false,
        enable_default_keybindings = true,
      },
    },
  },
  },

  -- project local plugins
  unpack(project_plugins)
}



lazy.setup(plugins, {
  defaults = {
    lazy = true,
  }
})
