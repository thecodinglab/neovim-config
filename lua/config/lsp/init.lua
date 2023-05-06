local lsp_host_config = require('util.host').lsp
if not lsp_host_config.enabled then
  return
end

local lspconfig_status_ok, _ = pcall(require, 'lspconfig')
if not lspconfig_status_ok then
  return
end

local mason_config = require('config.lsp.mason')

require('config.lsp.trouble')
require('config.lsp.neoconf')
require('config.lsp.neodev')
require('config.lsp.null_ls')

mason_config.setup()
