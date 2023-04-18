local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

local file_util = require('util.file')

treesitter.setup({
  ensure_installed = 'all',
  ignore_install = {},
  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true,
    is_supported = function()
      return not file_util.is_large_buffer(0)
    end
  },
  playground = {
    enable = true,
  },
})
