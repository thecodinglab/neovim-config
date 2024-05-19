local function organize_imports(timeout)
  local clients = vim.lsp.get_clients({
    name = 'gopls',
  })

  if not clients or not #clients then
    -- skip organization of imports when lsp is not ready
    return
  end

  local params = vim.lsp.util.make_range_params()
  params.context = {
    only = { 'source.organizeImports' }
  }

  local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, timeout)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, 'UTF-8')
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = vim.api.nvim_create_augroup('go_organize_imports', { clear = true }),
  pattern = { '*.go' },
  callback = function()
    organize_imports(300)
  end,
})
