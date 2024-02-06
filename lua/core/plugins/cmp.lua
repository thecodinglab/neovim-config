return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'nvim-tree/nvim-web-devicons',

    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',

    {
      'hrsh7th/cmp-vsnip',
      dependencies = { 'hrsh7th/vim-vsnip' },
    },
  },

  event = 'InsertEnter',

  opts = function()
    local cmp = require('cmp')
    local utils = require('utils')
    local devicons = require('nvim-web-devicons')

    local icons = {
      Text           =  '󰦨',
      Method         =  '',
      Function       =  '󰊕',
      Constructor    =  '',
      Field          =  '',
      Variable       =  '󰫧',
      Class          =  '',
      Interface      =  '',
      Module         =  '',
      Property       =  '',
      Unit           =  '󰑭',
      Value          =  '',
      Enum           =  '',
      Keyword        =  '',
      Snippet        =  '',
      Color          =  '',
      File           =  '',
      Reference      =  '',
      Folder         =  '',
      EnumMember     =  '',
      Constant       =  '',
      Struct         =  '',
      Event          =  '',
      Operator       =  '',
      TypeParameter  =  '',
    };

    return {
      preselect = 'none',

      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
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
            else
              cmp.complete()
            end
          end,
        },
        ['<C-n>'] = {
          i = function()
            if cmp.visible() then
              cmp.select_next_item()
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
        { name = 'vsnip' },
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
}
