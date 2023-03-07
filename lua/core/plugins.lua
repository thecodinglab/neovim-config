local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

return packer.startup(function(use)
  use { 'wbthomason/packer.nvim' }
  use { 'nvim-lua/plenary.nvim' }

  -- lsp
  use { 'neovim/nvim-lspconfig' }
  use { 'williamboman/mason.nvim' }
  use { 'williamboman/mason-lspconfig.nvim' }
  use { 'folke/trouble.nvim' }
  use { 'folke/neodev.nvim' }

  use { 'ms-jpq/coq_nvim', branch = 'coq' }
  use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }

  -- treesitter
  use { 'nvim-treesitter/nvim-treesitter' }
  use { 'nvim-treesitter/playground' }

  -- telescope
  use { 'nvim-telescope/telescope.nvim' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- nvim-tree
  use { 'nvim-tree/nvim-tree.lua' }

  -- theme
  use { 'navarasu/onedark.nvim' }
  use { 'nvim-tree/nvim-web-devicons' }

  -- other
  use { 'nvim-lualine/lualine.nvim' }
  use { 'akinsho/bufferline.nvim' }
  use { 'numToStr/Comment.nvim' }
  use { 'folke/todo-comments.nvim' }
  use { 'moll/vim-bbye' }

  -- syntax highlighting
  use { 'ARM9/arm-syntax-vim' }

  if packer_bootstrap then
    packer.sync()
  end
end)
