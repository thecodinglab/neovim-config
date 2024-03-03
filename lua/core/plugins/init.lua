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
  require('core.plugins.theme'),
  require('core.plugins.lualine'),

  require('core.plugins.treesitter'),
  require('core.plugins.snippets'),
  require('core.plugins.lsp'),
  require('core.plugins.cmp'),

  require('core.plugins.telescope'),
  require('core.plugins.explorer'),

  require('core.plugins.ai'),
  require('core.plugins.comments'),
  require('core.plugins.git'),
  require('core.plugins.harpoon'),
  require('core.plugins.tmux'),
  require('core.plugins.undotree'),

  require('core.plugins.projects.latex'),
  require('core.plugins.projects.obsidian'),
}, {
  defaults = { lazy = true, },
})
