local M = {
  MAX_FILESIZE = 100000, -- 100kb
}

function M.is_large_file(filename)
  local ok, stats = pcall(vim.loop.fs_stat, filename)
  if ok and stats and stats.size > M.MAX_FILESIZE then
    return true
  end
end

function M.is_large_buffer(bufnr)
  local num_lines = vim.api.nvim_buf_line_count(bufnr)
  local byte_size = vim.api.nvim_buf_get_offset(bufnr, num_lines)
  return byte_size > M.MAX_FILESIZE
end

return M
