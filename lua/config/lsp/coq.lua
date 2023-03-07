vim.g.coq_settings = {
  auto_start = 'shut-up',
  completion = {
    always = true,
  },
}

local status_ok, _ = pcall(require, 'coq')
if not status_ok then
  return
end
