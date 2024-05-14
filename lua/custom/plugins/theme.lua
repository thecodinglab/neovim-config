return {
  'thecodinglab/nord.nvim',
  init = function()
    vim.opt.termguicolors = true;
    vim.cmd.colorscheme('nord');
  end,
}
