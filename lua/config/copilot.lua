local status_ok, copilot = pcall(require, 'copilot')
if not status_ok then
  return
end

copilot.setup({
  panel = {
    layout = {
      position = 'right',
      ratio = 0.3,
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    keymap = {
      accept = '<C-l>',
    },
  },
})
