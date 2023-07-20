local file_util = require('util.file')

return {
  ensure_installed = 'all',
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
