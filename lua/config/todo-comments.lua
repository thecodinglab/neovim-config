return {
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
}
