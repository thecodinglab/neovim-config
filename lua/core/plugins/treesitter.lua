return {
  {
    'nvim-treesitter/nvim-treesitter',
    main = 'nvim-treesitter.configs',
    build = ':TSUpdate',

    event = { 'BufReadPre', 'BufNewFile' },

    opts = {
      ensure_installed = {},
      ignore_install = {},

      sync_install = false,
      auto_install = false,

      highlight = {
        enable = true,
        disable = function(lang, buf)
          if lang == 'latex' then
            return true
          end

          return require('utils').is_large_buffer(buf)
        end,
      },

      indent = {
        enable = true,
        disable = function(_, buf)
          return require('utils').is_large_buffer(buf)
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
