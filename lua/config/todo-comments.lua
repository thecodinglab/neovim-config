local status_ok, todo_comments = pcall(require, 'todo-comments')
if not status_ok then
  return
end

todo_comments.setup({
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
})
