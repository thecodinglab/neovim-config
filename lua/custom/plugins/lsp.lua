local function configure_lsp_server(server, extra)
  local lspconfig = require('lspconfig')[server]

  local config = {
    capabilities = vim.lsp.protocol.make_client_capabilities(),
  }

  config.capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
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

local function configure_ltex()
  local ltex_settings = {}

  local username = os.getenv('LANGUAGETOOL_USERNAME')
  local token = os.getenv('LANGUAGETOOL_TOKEN')

  if username and token then
    ltex_settings['languageToolHttpServerUrl'] = 'https://api.languagetoolplus.com'
    ltex_settings['languageToolOrg'] = {
      username = username,
      apiKey = token,

    }
  end

  configure_lsp_server('ltex', {
    settings = {
      ltex = ltex_settings,
    },
  })
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'j-hui/fidget.nvim',
      'folke/neoconf.nvim',
    },
    event = 'VeryLazy',

    config = function()
      configure_ltex()
      configure_lsp_server('lua_ls')
      configure_lsp_server('nixd', {
        settings = {
          nixd = {
            formatting = {
              command = 'nixpkgs-fmt',
            },
          },
        },
      })

      configure_lsp_server('gopls', {
        settings = {
          gopls = {
            ['local'] = 'github.com/thecodinglab', -- TODO: detect current module from `go.mod`
          },
        },
      })

      configure_lsp_server('tsserver')
      configure_lsp_server('eslint')

      configure_lsp_server('clangd')
      configure_lsp_server('hls')
      configure_lsp_server('pyright')
      configure_lsp_server('rust_analyzer')
      configure_lsp_server('texlab')
      configure_lsp_server('yamlls', {
        settings = {
          yaml = {
            schemas = {
              kubernetes = '*.yaml',
            },
          },
        },
      })
    end,
  },

  { 'folke/neoconf.nvim', opts = {} },

  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    cmd = { 'Trouble' },
    keys = {
      { '<leader>xx', '<cmd>Trouble<cr>' },
      { '<leader>xd', '<cmd>Trouble diagnostics toggle<cr>' },
    },

    opts = {},
  },

  {
    'j-hui/fidget.nvim',

    event = 'VeryLazy',

    opts = {
      notification = {
        -- suggested by catppuccin
        window = {
          winblend = 0,
        },

        override_vim_notify = true,
      },
    },
  }
}
