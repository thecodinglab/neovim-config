local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

treesitter.setup({
  ensure_installed = 'all',
  ignore_install = {},

  sync_install = false,
  auto_install = false,

  highlight = {
    enable = true,
  },

  playground = {
    enable = true,
  }
})
