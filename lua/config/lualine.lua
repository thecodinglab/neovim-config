local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
  return
end

lualine.setup({
  options = {
    icons_enabled = true,
    theme = 'onedark',
    disabled_filetypes = { 'neo-tree', 'Outline' },
  },
})
