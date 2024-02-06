return {
  'ms-jpq/coq_nvim',
  build = ':COQdeps',

  dependencies = {
    { 'ms-jpq/coq.artifacts', branch = 'artifacts' },
  },

  init = function()
    vim.g.coq_settings = {
      auto_start = 'shut-up',
      keymap = {
        recommended = false,
        pre_select = false,

        manual_complete = '<C-n>',
        jump_to_mark = '<C-m>',
      },
    }

    require('coq')
  end,
}
