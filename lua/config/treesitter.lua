local file_util = require('util.file')

return {
  -- TODO: enable treesitter installed packages
  -- ensure_installed = 'all',
  ensure_installed = { 'go' },
  ignore_install = {},

  sync_install = false,
  auto_install = false,

  highlight = {
    enable = true,
    disable = function(_, buf)
      return file_util.is_large_buffer(buf)
    end
  },

  playground = {
    enable = true,
  },
}
