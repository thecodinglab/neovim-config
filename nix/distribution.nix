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

, languageToolUsername ? null
, languageToolToken ? null
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

  extraWrapperArgs =
    [ "--suffix" "PATH" ":" (lib.makeBinPath deps) ]
    ++ (lib.optionals (languageToolUsername != null) [ "--set" "LANGUAGETOOL_USERNAME" languageToolUsername ])
    ++ (lib.optionals (languageToolToken != null) [ "--set" "LANGUAGETOOL_TOKEN" languageToolToken ]);

  res = neovimUtils.makeNeovimConfig {
    withPython3 = false;
    withRuby = false;

    plugins = [
      custom-config
    ];
  };
in
wrapNeovimUnstable neovim-unwrapped (res // {
  wrapperArgs = lib.escapeShellArgs (res.wrapperArgs ++ extraWrapperArgs);
})
