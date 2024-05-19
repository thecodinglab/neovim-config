local utils = require('custom.utils')

local function custom_previewer_maker(filepath, bufnr, opts)
  if utils.is_large_file(filepath) then
    return
  end

  require('telescope.previewers').buffer_previewer_maker(filepath, bufnr, opts)
end

return {
  'nvim-telescope/telescope.nvim',

  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
  },

  cmd = 'Telescope',
  keys = {
    { '<leader>fp', function() require('telescope.builtin').resume() end,       mode = { 'n', 'v' } },
    { '<leader>ff', function() require('telescope.builtin').find_files() end,   mode = { 'n', 'v' } },
    { '<leader>fb', function() require('telescope.builtin').buffers() end,      mode = { 'n', 'v' } },
    { '<leader>fh', function() require('telescope.builtin').help_tags() end,    mode = { 'n', 'v' } },
    { '<leader>fd', function() require('telescope.builtin').diagnostics() end,  mode = { 'n', 'v' } },

    { '<leader>fg', function() require('telescope.builtin').git_branches() end, mode = { 'n', 'v' } },
    { '<leader>fc', function() require('telescope.builtin').git_commits() end,  mode = { 'n', 'v' } },
    { '<leader>fC', function() require('telescope.builtin').git_bcommits() end, mode = { 'n', 'v' } },

    {
      '<leader>fs',
      function()
        vim.ui.input({ prompt = 'grep > ' }, function(value)
          if value == '' then
            return
          end

          require('telescope.builtin').grep_string({ search = value })
        end)
      end,
      mode = { 'n' }
    },
    { '<leader>fs', function() require('telescope.builtin').grep_string({ search = utils.get_visual_selection() }) end, mode = { 'v' } },
  },

  opts = {
    defaults = {
      buffer_previewer_maker = custom_previewer_maker,
    },
    pickers = {
      find_files = {
        find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' }
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case',
      },
    },
  },

  config = function(_, opts)
    local telescope = require('telescope')
    telescope.setup(opts)

    telescope.load_extension('fzf')
    telescope.load_extension('ui-select')
  end,
}
