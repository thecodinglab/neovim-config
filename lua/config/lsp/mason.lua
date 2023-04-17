local status_ok, mason = pcall(require, 'mason')
if not status_ok then
  return
end

mason.setup({})

function ensure_installed_packages()
  local Package = require('mason-core.package')
  local registry = require('mason-registry')

  local server_config = require('config.lsp.server')
  for _, server in pairs(server_config.ensure_installed) do
    local name, version = Package.Parse(server)
    local pkg = registry.get_package(name)

    if not pkg:is_installed() then
      pkg:install({
        version = version,
      })
    end
  end
end

ensure_installed_packages()
