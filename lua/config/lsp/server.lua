local M = {
  clangd = {
    config = {
      -- all supported filetypes without protobuf
      filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
    }
  },

  tsserver = {
    autoformat = false,
    config = {
      init_options = {
        preferences = {
          importModuleSpecifierPreference = 'non-relative',
        },
      },
    },
  },
}

local ok, project = pcall(require, 'project.lsp.server')
if ok then
  M = vim.tbl_deep_extend('force', M, project)
end

return M
