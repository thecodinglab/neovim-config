local status_ok, null_ls = pcall(require, 'null-ls')
if not status_ok then
  return
end

local file_util = require('util.file')

null_ls.setup({
  sources = {
    -- General
    null_ls.builtins.diagnostics.codespell,

    -- Protobuf
    null_ls.builtins.diagnostics.buf,

    -- Golang
    null_ls.builtins.diagnostics.golangci_lint,

    -- JavaScript/TypeScript
    null_ls.builtins.code_actions.eslint,
    null_ls.builtins.formatting.prettier,
  },
  should_attach = function(bufnr)
    return not file_util.is_large_buffer(bufnr)
  end,
})
