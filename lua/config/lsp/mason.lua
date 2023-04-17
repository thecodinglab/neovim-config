local M = {}

local mason_status_ok, mason = pcall(require, 'mason')
if not mason_status_ok then
  return M
end

mason.setup({})

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_status_ok then
  return M
end

local mappings = require('config.lsp.mappings')
local server_config = require('config.lsp.server')

mason_lspconfig.setup({
  ensure_installed = server_config.enabled,
})

function M.get_global_capabilities()
  if not M.global_capabilities then
    local global_capabilities = {
      offsetEncoding = 'utf-8',
    }

    local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
    global_capabilities = vim.tbl_deep_extend('force', global_capabilities, cmp_capabilities)

    M.global_capabilities = global_capabilities
  end

  return M.global_capabilities
end

function M.get_config(server_name)
  local global_capabilities = M.get_global_capabilities()

  local config = server_config[server_name] or {}
  config.on_attach = mappings.on_attach

  if config.capabilities then
    config.capabilities = vim.tbl_deep_extend('force', global_capabilities, config.capabilities)
  else
    config.capabilities = global_capabilities
  end

  return config
end

function M.setup()
  mason_lspconfig.setup_handlers({
    function(server_name)
      local config = M.get_config(server_name)
      require('lspconfig')[server_name].setup(config)
    end
  })
end

return M
