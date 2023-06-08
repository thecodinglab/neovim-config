local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
  return
end

local theme = require('core.theme')

local lualine_theme = 'onedark'
if theme.is_light() then
  lualine_theme = 'onelight'
end

lualine.setup({
  options = {
    icons_enabled = true,
    theme = lualine_theme,
    disabled_filetypes = { 'neo-tree', 'Outline' },
  },
})
