local pattern = vim.regex([[\v/(templates)/.*\.(ya?ml|tpl|txt)$]])

local function is_helm(filepath)
  if pattern:match_str(filepath) then
    return true
  end

  return false
end

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('helm_ftdetect', { clear = true }),
  pattern = { '*.yml', '*.yaml', '*.tpl' },
  callback = function(event)
    if is_helm(event.file) then
      vim.opt_local.filetype = 'helm'
    end
  end,
})
