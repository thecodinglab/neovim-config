local function custom_previewer_maker(filepath, bufnr, opts)
  if require('utils.file').is_large_file(filepath) then
    return
  end

  require('telescope.previewers').buffer_previewer_maker(filepath, bufnr, opts)
end

return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
  
  cmd = 'Telescope',
  keys = {
    { '<leader>f', function(...) require('telescope.builtin').find_files(...) end },
    { '<leader>F', function(...) require('telescope.builtin').live_grep(...) end },
    { '<leader><leader>', function(...) require('telescope.builtin').buffers(...) end },
  },

  opts = {
    defaults = {
      vimgrep_arguments = { 'ag', '--vimgrep' },
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
  end,
}
