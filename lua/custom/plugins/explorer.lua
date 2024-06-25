return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },

  event = 'VeryLazy',
  keys = {
    { '<leader>nf', '<cmd>Oil<cr>' },
  },

  opts = {
    default_file_explorer = true,
    skip_confirm_for_simple_edits = true,
  },
}
