{ lib
, callPackage

, neovim-unwrapped
, neovimUtils
, wrapNeovimUnstable

, git
, gcc
, gnumake
, cmake
, fd
, ripgrep

, custom-config ? callPackage ./config.nix { }
, preinstalled-lsp ? [ ]
}:
let
  deps = [
    # required by lazy to fetch plugins
    git

    # required to build native libraries for things like treesitter
    # or nvim-telesceope-fzf-native
    gcc
    gnumake
    cmake

    # required for fuzzy finding in telescope
    fd
    ripgrep
  ] ++ preinstalled-lsp;

  extraWrapperArgs = [ "--suffix" "PATH" ":" (lib.makeBinPath deps) ];

  res = neovimUtils.makeNeovimConfig {
    plugins = [
      custom-config
    ];
  };
in
wrapNeovimUnstable neovim-unwrapped (res // {
  wrapperArgs = lib.escapeShellArgs (res.wrapperArgs ++ extraWrapperArgs);
})
