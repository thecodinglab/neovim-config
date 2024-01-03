local M = {}

function M.build_capabilities(opts)
  local capabilities = {
    offsetEncoding = 'utf-8',
  }

  -- TODO: does this always load cmp?
  local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
  capabilities = vim.tbl_deep_extend('force', capabilities, cmp_capabilities)

  if opts and opts.capabilities then
    capabilities = vim.tbl_deep_extend('force', capabilities, opts.capabilities)
  end

  return capabilities
end

function M.configure_server(server_name, opts)
  local capabilities = M.build_capabilities(opts)

  local config = {
    on_attach = require('config.lsp.mappings').on_attach
  }

  if opts and opts.config then
    config = vim.tbl_deep_extend('force', config, opts.config)
  end

  require('lspconfig')[server_name].setup(config)
end

function M.setup()
  local configs = require('config.lsp.server')
  for name, opts in pairs(configs) do
    M.configure_server(name, opts);
  end
end

return M
