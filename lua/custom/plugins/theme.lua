return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,

  opts = {
    flavour = 'mocha',
    transparent_background = true,

    integrations = {
      fidget = true,
    },
  },

  init = function()
    vim.opt.termguicolors = true
    vim.cmd.colorscheme('catppuccin')
  end,
}
