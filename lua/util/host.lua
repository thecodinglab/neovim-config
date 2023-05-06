local M = {
  lsp = {
    enabled = true,
    autoformat = true,
    server = {},
  },
  plugins = {},
}

function M.load()
  M.lsp = M.load_host_config('lsp', M.lsp)
end

function M.load_host_config(name, default)
  local status_ok, host_config = pcall(require, 'config.host.' .. name)
  if not status_ok then
    return default
  end

  return vim.tbl_deep_extend('keep', host_config, default)
end

return M
