return {
  {
    'nvim-treesitter/nvim-treesitter',
    main = 'nvim-treesitter.configs',
    build = ':TSUpdate',

    lazy = false,

    opts = {
      ensure_installed = {},
      ignore_install = {},

      sync_install = false,
      auto_install = false,

      highlight = {
        enable = true,
        disable = function(lang, buf)
          return require('custom.utils').is_large_buffer(buf)
        end,
      },

      indent = {
        enable = true,
        disable = function(_, buf)
          return require('custom.utils').is_large_buffer(buf)
        end,
      },

      playground = {
        enable = true,
      },
    },
  },

  {
    'nvim-treesitter/nvim-treesitter-context',
    cmd = { 'TSContextEnable', 'TSContextDisable', 'TSContextToggle' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },

  {
    'nvim-treesitter/playground',
    cmd = 'TSPlaygroundToggle',
    dependencies = { 'nvim-treesitter/nvim-treesitter' }
  },
}
