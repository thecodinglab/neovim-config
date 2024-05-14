vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local opts = { noremap = true, silent = true }

-- map escape to clear highlights in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>noh<cr>', opts)

-- indent while staying in visual mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- clipboard
vim.keymap.set('v', '<leader>y', '"+y', opts)
vim.keymap.set('n', '<leader>p', '"+p', opts)

-- save
vim.keymap.set('n', '<leader>w', '<cmd>silent write<cr>', opts)

-- diagnostics
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- lsp

local function hover_highlight(client, bufnr)
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

local function autoformat(client, bufnr)
  if not client.server_capabilities.documentFormattingProvider then
    return
  end

  vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    buffer = bufnr,
    group = vim.api.nvim_create_augroup('lsp_autoformat', { clear = false }),
    callback = function()
      vim.lsp.buf.format({ bufnr = bufnr, async = false, timeout_ms = 150 })
    end,
  })
end

local function keymap(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<c-p>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('i', '<c-p>', vim.lsp.buf.signature_help, bufopts)

  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)

  vim.keymap.set('n', '<leader>l', vim.lsp.buf.format, bufopts)

  -- TODO: this loads telescope
  local telescope_status_ok, telescope = pcall(require, 'telescope.builtin')
  if telescope_status_ok then
    vim.keymap.set('n', 'gd', telescope.lsp_definitions, bufopts)
    vim.keymap.set('n', 'gr', telescope.lsp_references, bufopts)
    vim.keymap.set('n', 'gi', telescope.lsp_implementations, bufopts)
    vim.keymap.set('n', 'go', telescope.lsp_type_definitions, bufopts)

    vim.keymap.set('n', '<leader>sd', telescope.lsp_document_symbols, bufopts)
    vim.keymap.set('n', '<leader>sw', telescope.lsp_dynamic_workspace_symbols, bufopts)
  else
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, bufopts)
  end
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp_mappings', {}),
  callback = function(event)
    local bufnr = event.buf
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    -- disable formatting using tsserver as it takes forever and slows down
    -- my development workflow
    if client.name == 'tsserver' then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end

    -- enable formatting using eslint
    if client.name == 'eslint' then
      client.server_capabilities.documentFormattingProvider = true
      client.server_capabilities.documentRangeFormattingProvider = true
    end

    hover_highlight(client, bufnr)
    keymap(client, bufnr)

    autoformat(client, bufnr)
  end,
})
