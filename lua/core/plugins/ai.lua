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
    event = 'InsertEnter',

    opts = {
      panel = {
        enabled = true,
        auto_refresh = true,
        layout = {
          position = 'bottom',
          ratio = 0.3,
        },
      },
      suggestion = {
        enabled = false,
        auto_trigger = true,
        keymap = {
          accept = '<C-a>',
        },
      },
    },
  },
}
