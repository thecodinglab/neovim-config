local capabilities = require('core.plugins.lsp.capabilities')

local function configure(server, extra)
  local config = {
    capabilities = capabilities.supported(server),
  }
  
  if extra then
    config = vim.tbl_deep_extend('force', config, extra)
  end

  require('lspconfig')[server].setup(config)
end

return {
  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',

    config = function()
      require('core.plugins.lsp.mappings').setup()

      configure('gopls')
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

    opts = {},
  }
}
