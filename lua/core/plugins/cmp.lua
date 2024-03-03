return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'nvim-tree/nvim-web-devicons',

    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',

    {
      'saadparwaiz1/cmp_luasnip',
      dependencies = { 'L3MON4D3/LuaSnip' },
    },

    'micangl/cmp-vimtex',
  },

  event = 'InsertEnter',

  opts = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local utils = require('utils')

    local icons = {
      Text          = '󰦨',
      Method        = '',
      Function      = '󰊕',
      Constructor   = '',
      Field         = '',
      Variable      = '󰫧',
      Class         = '',
      Interface     = '',
      Module        = '',
      Property      = '',
      Unit          = '󰑭',
      Value         = '',
      Enum          = '',
      Keyword       = '',
      Snippet       = '',
      Color         = '',
      File          = '',
      Reference     = '',
      Folder        = '',
      EnumMember    = '',
      Constant      = '',
      Struct        = '',
      Event         = '',
      Operator      = '',
      TypeParameter = '',
    };

    return {
      preselect = 'none',

      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },

      mapping = {
        -- close/abort
        ['<C-e>'] = { i = cmp.mapping.close() },
        ['<C-c>'] = { i = cmp.mapping.abort() },

        -- accept
        ['<C-y>'] = { i = cmp.mapping.confirm({ select = false }) },

        -- item selection
        ['<C-p>'] = {
          i = function()
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              cmp.complete()
            end
          end,
        },
        ['<C-n>'] = {
          i = function()
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              cmp.complete()
            end
          end,
        },
      },

      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(_, vim_item)
          vim_item.kind = string.format('%s', icons[vim_item.kind])
          return vim_item
        end,
      },

      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        {
          name = 'buffer',
          option = {
            get_bufnrs = function()
              local all_buffers = vim.api.nvim_list_bufs()
              local selected_buffers = {}

              for _, buf in pairs(all_buffers) do
                -- prevent trying to complete stuff from huge files
                if not utils.is_large_buffer(buf) then
                  table.insert(selected_buffers, buf)
                end
              end

              return selected_buffers
            end
          },
        },
        { name = 'path' },
      }),
    }
  end,

  config = function(_, opts)
    local cmp = require('cmp')

    cmp.setup(opts)
    cmp.setup.filetype("tex", {
      sources = {
        { name = 'vimtex' },
      },
    })
  end,
}
