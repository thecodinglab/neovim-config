local M = {
  DARK = 'dark',
  LIGHT = 'light',

  theme = 'dark',
}

function M.is_dark()
  return M.theme == M.DARK
end

function M.is_light()
  return M.theme == M.LIGHT
end

local function determine_os_theme()
  local paths = vim.api.nvim_list_runtime_paths()
  for _, path in ipairs(paths) do
    local script = path .. '/scripts/os_theme.sh'

    local handle = io.popen(script)
    if handle ~= nil then
      local result = handle:read('*a')
      handle:close()

      if result ~= nil and result ~= 'unknown' then
        return result:gsub('%s+', '')
      end
    end
  end

  return M.DARK
end

local function select(theme)
  M.theme = theme

  local variant = 'main'
  if M.is_light() then
    variant = 'dawn'
  end

  require('rose-pine').colorscheme(variant)
end


M.select = select

select(determine_os_theme())

return M
