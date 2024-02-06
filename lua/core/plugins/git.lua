return {
  {
    'lewis6991/gitsigns.nvim',

    event = { 'BufRead', 'BufWinEnter', 'BufNewFile' },
    keys = {
      { '<leader>gs', '<cmd>Gitsigns stage_hunk<cr>' },
    },

    opts = {
      signcolumn = true,
      trouble = false,
    },
  },

  {
    'tpope/vim-fugitive',

    cmd = { 'Git' },
    keys = {
      { '<leader>ng', '<cmd>Git<cr>' },
      { '<leader>ga', '<cmd>Git add %<cr>' },
      { '<leader>gu', '<cmd>Git restore --staged %<cr>' },
    },
  },
}
