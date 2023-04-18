local status_ok, rosepine = pcall(require, 'rose-pine')
if not status_ok then
  return
end

rosepine.setup({
  variant = 'main',
})

vim.cmd.colorscheme('rose-pine')
