return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },

    keys = {
      { '<leader>a', function() require('harpoon'):list():append() end },
      {
        '<C-e>',
        function()
          local harpoon = require('harpoon')
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end
      },

      { '<leader>1', function() require('harpoon'):list():select(1) end },
      { '<leader>2', function() require('harpoon'):list():select(2) end },
      { '<leader>3', function() require('harpoon'):list():select(3) end },
      { '<leader>4', function() require('harpoon'):list():select(4) end },
    },

    opts = {},
  },

  {
    'ggandor/leap.nvim',

    keys = {
      { "s", mode = { "n", "x", "o" } },
      { "S", mode = { "n", "x", "o" } },
      { "gs", mode = { "n", "x", "o" } },
    },

    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
  },

  {
    'folke/zen-mode.nvim',

    cmd = 'ZenMode',
    keys = {
      { '<leader>z', '<cmd>ZenMode<cr>' },
    },

    opts = {
      window = {
        backdrop = 1,
        width = 80,

        options = {
          signcolumn = 'no',
          colorcolumn = '0',
          number = false,
          relativenumber = false,
          wrap = true,
        },
      },

      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = true,
          laststatus = true,
        },

        twilight = { enabled = true },
        gitsigns = { enabled = true },
        tmux = { enabled = true },

        alacritty = {
          enabled = true,
          font = "14",
        },
      },
    },
  }
}
