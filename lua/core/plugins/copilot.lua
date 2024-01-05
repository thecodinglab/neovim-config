return {
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
      enabled = false,
      auto_trigger = true,
      keymap = {
        accept = '<C-l>',
      },
    },
  },
}
