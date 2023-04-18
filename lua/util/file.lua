local M = {
  MAX_FILESIZE = 10000, -- 10kb
}

function M.is_large_file(filename)
  return vim.fn.getfsize(filename) > M.MAX_FILESIZE
end

function M.is_large_buffer(bufnr)
  local filename = vim.api.nvim_buf_get_name(bufnr)
  return M.is_large_file(filename)
end

function M.has_large_files()
  local buffers = vim.api.nvim_list_bufs()
  for _, buf in ipairs(buffers) do
    if M.is_large_buffer(buf) then
      return true
    end
  end

  return false
end

function M.run_setup_on_small_files(name, setup_callback)
  local augroup = vim.api.nvim_create_augroup(name .. '_buffer_setup', { clear = true })

  local callback_wrapper = function()
    if M.has_large_files() then
      return
    end

    setup_callback()
  end

  vim.api.nvim_create_autocmd({ 'BufNewFile' }, {
    group = augroup,
    callback = callback_wrapper,
  })

  vim.api.nvim_create_autocmd({ 'BufReadPre' }, {
    group = augroup,
    callback = callback_wrapper,
  })
end

return M
