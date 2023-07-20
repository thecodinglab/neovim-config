local theme = require('core.theme')

local lualine_theme = 'onedark'
if theme.is_light() then
  lualine_theme = 'onelight'
end

return {
  options = {
    icons_enabled = true,
    theme = lualine_theme,
    disabled_filetypes = { 'neo-tree', 'Outline' },
  },
}
