local function custom_previewer_maker(filepath, bufnr, opts)
  local previewers = require('telescope.previewers')
  local file_util = require('util.file')

  if file_util.is_large_file(filepath) then
    return
  end

  previewers.buffer_previewer_maker(filepath, bufnr, opts)
end

return {
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
}
