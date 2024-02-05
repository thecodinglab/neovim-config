return {
  'ms-jpq/coq_nvim',
  build = ':COQdeps',

  dependencies = {
    { 'ms-jpq/coq.artifacts', branch = 'artifacts' },
  },

  init = function()
    vim.g.coq_settings = {
      auto_start = 'shut-up',
    }

    require('coq')
  end,
}
