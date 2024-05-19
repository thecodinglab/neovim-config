local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  -- clone lazy if not already exists
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
  return
end

lazy.setup({
  require('custom.plugins.theme'),
  require('custom.plugins.lualine'),

  require('custom.plugins.treesitter'),
  require('custom.plugins.snippets'),
  require('custom.plugins.lsp'),
  require('custom.plugins.cmp'),

  require('custom.plugins.telescope'),
  require('custom.plugins.explorer'),

  require('custom.plugins.comments'),
  require('custom.plugins.git'),
  require('custom.plugins.mini'),
  require('custom.plugins.tmux'),
  require('custom.plugins.undotree'),

  require('custom.plugins.projects.latex'),
  require('custom.plugins.projects.obsidian'),
}, {
  defaults = { lazy = true, },
  performance = {
    rtp = {
      reset = false,
    },
  },
})
