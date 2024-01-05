return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufRead', 'BufWinEnter', 'BufNewFile' },

  opts = {
    signcolumn = true,
    trouble = false,
  },
}
