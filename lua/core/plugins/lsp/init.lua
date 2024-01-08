local capabilities = require('core.plugins.lsp.capabilities')

local function configure(server, extra)
  local lspconfig = require('lspconfig')[server]
  local defaults = lspconfig.document_config.default_config
  
  if vim.fn.executable(defaults.cmd[1]) == 0 then
    if extra and extra.required then
      vim.notify('LSP: ' .. server .. ' is not available', vim.log.levels.WARN)
    end

    return false
  end

  local config = {
    capabilities = capabilities.supported(server),
  }
  
  if extra then
    config = vim.tbl_deep_extend('force', config, extra)
  end

  lspconfig.setup(config)
  return true
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'j-hui/fidget.nvim' },
    event = 'VeryLazy',

    config = function()
      require('core.plugins.lsp.mappings').setup()

      configure('gopls')
      configure('rnix')
    end,
  },
  
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    cmd = { 'Trouble', 'TroubleToggle' },
    keys = {
      { '<leader>xx', '<cmd>TroubleToggle<cr>' },
      { '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>' },
      { '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>' },
    },

    opts = {},
  },

  {
    'j-hui/fidget.nvim',

    event = 'VeryLazy',

    opts = {
      notification = {
        override_vim_notify = true,
      },
    },
  }
}
