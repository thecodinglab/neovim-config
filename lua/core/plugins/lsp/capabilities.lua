return {
  supported = function()
    local capabilities = {
      offsetEncoding = 'utf-8',
    }

    local cmp_status_ok, cmp = pcall(require, 'cmp_nvim_lsp')
    if cmp_status_ok then
      capabilities = vim.tbl_deep_extend('force', capabilities, cmp.default_capabilities())
    end

    return capabilities
  end,
}
