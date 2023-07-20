local M = {}

local function lsp_hover_highlight(client, bufnr)
  if not client.server_capabilities.documentHighlightProvider then
    return
  end

  vim.api.nvim_create_autocmd({ 'CursorHold' }, {
    buffer = bufnr,
    group = vim.api.nvim_create_augroup('lsp_document_highlight_hold', { clear = false }),
    callback = function()
      vim.lsp.buf.document_highlight()
    end,
  })

  vim.api.nvim_create_autocmd({ 'CursorMoved' }, {
    buffer = bufnr,
    group = vim.api.nvim_create_augroup('lsp_document_highlight_moved', { clear = false }),
    callback = function()
      vim.lsp.buf.clear_references()
    end,
  })
end

local function lsp_autoformat(client, bufnr)
  if not client.server_capabilities.documentFormattingProvider then
    return
  end

  vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    buffer = bufnr,
    group = vim.api.nvim_create_augroup('lsp_autoformat', { clear = false }),
    callback = function()
      vim.lsp.buf.format({ bufnr = bufnr, async = false })
    end,
  })
end

local function lsp_keymap(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<c-p>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('i', '<c-p>', vim.lsp.buf.signature_help, bufopts)

  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)

  vim.keymap.set('n', '<leader>l', vim.lsp.buf.format, bufopts)

  local telescope_status_ok, telescope = pcall(require, 'telescope.builtin')
  if telescope_status_ok then
    vim.keymap.set('n', 'gd', telescope.lsp_definitions, bufopts)
    vim.keymap.set('n', 'gr', telescope.lsp_references, bufopts)
    vim.keymap.set('n', 'gi', telescope.lsp_implementations, bufopts)
    vim.keymap.set('n', '<leader>D', telescope.lsp_type_definitions, bufopts)

    vim.keymap.set('n', '<leader>s', telescope.lsp_document_symbols, bufopts)
    vim.keymap.set('n', '<leader>S', telescope.lsp_dynamic_workspace_symbols, bufopts)
  else
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  end
end

function M.on_attach(client, bufnr)
  lsp_hover_highlight(client, bufnr)
  lsp_keymap(client, bufnr)
  
  local opts = require('config.lsp.server')[client.name]
  if not opts or not (opts.autoformat == false) then
    lsp_autoformat(client, bufnr)
  end
end

return M
