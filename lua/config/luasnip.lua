local M = {}

function M.config()
  require('luasnip.loaders.from_vscode').lazy_load()
  require('luasnip.loaders.from_lua').lazy_load()
end

return M
