return {
  enabled = {
    'clangd',
    'gopls',
    'lua_ls',
    'tsserver',
  },
  tsserver = {
    init_options = {
      preferences = {
        importModuleSpecifierPreference = 'non-relative',
      },
    }
  }
}
