local status_ok, comment = pcall(require, 'Comment')
if not status_ok then
  return
end

comment.setup({
  toggler = {
    line = '<leader>/',
    block = '<leader>b/',
  },
  opleader = {
    line = '<leader>/',
    block = '<leader>b/',
  },
})
