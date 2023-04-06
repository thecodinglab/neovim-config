local lspconfig_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status_ok then
  return
end

local mappings = require('config.lsp.mappings')
local server_config = require('config.lsp.server')

require('config.lsp.mason')
require('config.lsp.trouble')
require('config.lsp.neoconf')
require('config.lsp.neodev')
require('config.lsp.null_ls')

local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()

for _, server in pairs(server_config.enabled) do
  local config = server_config[server] or {}
  config.on_attach = mappings.on_attach

  if config.capabilities then
    config.capabilities = vim.tbl_deep_extend('force', cmp_capabilities, config.capabilities)
  else
    config.capabilities = cmp_capabilities
  end


  lspconfig[server].setup(config)
end
