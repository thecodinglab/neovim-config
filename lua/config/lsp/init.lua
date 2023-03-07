local lspconfig_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status_ok then
  return
end

local mappings = require('config.lsp.mappings')
local server_config = require('config.lsp.server')

require('config.lsp.coq')
require('config.lsp.mason')
require('config.lsp.trouble')
require('config.lsp.neodev')

local coq_status_ok, coq = pcall(require, 'coq')
if not coq_status_ok then
  return
end

for _, server in pairs(server_config.enabled) do
  local config = server_config[server] or {}
  config.on_attach = mappings.on_attach

  lspconfig[server].setup(
    coq.lsp_ensure_capabilities(config)
  )
end
