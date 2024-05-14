local function configure(server, extra)
  local lspconfig = require('lspconfig')[server]

  local config = {
    capabilities = vim.lsp.protocol.make_client_capabilities(),
  }

  local cmp_status_ok, cmp = pcall(require, 'cmp_nvim_lsp')
  if cmp_status_ok then
    config.capabilities = vim.tbl_deep_extend('force', config.capabilities, cmp.default_capabilities())
  end

  local coq_status_ok, coq = pcall(require, 'coq')
  if coq_status_ok then
    config = coq.lsp_ensure_capabilities(config)
  end

  if extra then
    config = vim.tbl_deep_extend('force', config, extra)
  end

  lspconfig.setup(config)
  return true
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'j-hui/fidget.nvim',
      'folke/neoconf.nvim',
      'folke/neodev.nvim',
    },
    event = 'VeryLazy',

    config = function()
      -- preinstalled
      configure('ltex')
      configure('lua_ls')
      configure('nixd', {
        settings = {
          nixd = {
            formatting = {
              command = "nixpkgs-fmt",
            },
          },
        },
      })

      configure('tsserver')
      configure('eslint')

      -- dynamic
      configure('texlab')
      configure('gopls', {
        settings = {
          gopls = {
            ['local'] = 'github.com/thecodinglab', -- TODO: detect current module from `go.mod`
          },
        },
      })
      configure('hls')
      configure('rust_analyzer')
      configure('pyright')
    end,
  },

  { 'folke/neoconf.nvim', opts = {} },
  { 'folke/neodev.nvim',  opts = {} },

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
