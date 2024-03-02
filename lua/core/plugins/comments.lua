return {
  {
    'numToStr/Comment.nvim',

    keys = {
      { '<leader>/', mode = { 'n', 'v' } },
    },

    opts = {
      toggler = {
        line = '<leader>/',
      },
      opleader = {
        line = '<leader>/',
      },
      extra = {},
    },
  },

  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = { 'BufRead', 'BufWinEnter', 'BufNewFile' },

    opts = {
      highlight = {
        before = '',
        keyword = 'bg',
        after = 'fg',
        pattern = [[.*<(KEYWORDS)(\([^\)]*\))?:]],
        comments_only = true,
      },
      search = {
        command = 'ag',
        args = { '--vimgrep' },
        pattern = [[(KEYWORDS)(\(\w+\))?:]]
        -- pattern = '\\b(KEYWORDS)(\\(\\w+\\))?:',
      },
    },
  },
}
