return {
  {
    'David-Kunz/gen.nvim',

    cmd = 'Gen',

    opts = {
      model = 'mistral',
      display_mode = 'nofloat',
    },
  },

  {
    'zbirenbaum/copilot.lua',
    build = ':Copilot auth',

    cmd = 'Copilot',

    opts = {
      panel = {
        layout = {
          position = 'right',
          ratio = 0.3,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = '<C-a>',
        },
      },
    },
  },
}
