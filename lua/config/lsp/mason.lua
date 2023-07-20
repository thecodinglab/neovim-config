return {
  mason = {},

  mason_lspconfig = {
    ensure_installed = {
      'lua_ls',

      'clangd',
      'gopls',
    },
  },
}
