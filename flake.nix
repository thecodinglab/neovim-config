{
  description = "personal neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    neovim = {
      url = "github:neovim/neovim/release-0.10?dir=contrib";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };

  outputs = { self, nixpkgs, flake-utils, neovim }:
    let
      lib = rec {
        makePlugin = (pkgs: pkgs.stdenv.mkDerivation {
          name = "neovim-lua-config";
          src = ./.;

          dontUseCmakeConfigure = true;

          installPhase = ''
            cp -r . $out/
          '';
        });

        makeDistribution = (pkgs:
          let
            deps = [
              # required to fetch plugins
              pkgs.git

              # required to build native libraries for things like treesitter
              # or nvim-telesceope-fzf-native
              pkgs.gcc
              pkgs.gnumake
              pkgs.cmake

              # required for fuzzy finding in telescope
              pkgs.fd
              pkgs.ripgrep

              # preinstalled lsp
              pkgs.ltex-ls
              pkgs.lua-language-server
              pkgs.nixd
              pkgs.nixpkgs-fmt

              pkgs.nodePackages.typescript-language-server
              pkgs.vscode-langservers-extracted
            ];

            extraWrapperArgs = [
              "--suffix"
              "PATH"
              ":"
              (pkgs.lib.makeBinPath deps)
            ];

            config = pkgs.neovimUtils.makeNeovimConfig {
              plugins = [
                { plugin = makePlugin pkgs; optional = false; }
              ];
            };
          in
          pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped (config // {
            wrapperArgs = pkgs.lib.escapeShellArgs
              (config.wrapperArgs ++ extraWrapperArgs);
          }));
      };
    in
    lib //
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;

          overlays = [
            (final: prev: {
              neovim-unwrapped = neovim.packages.${prev.system}.default.overrideAttrs
                (final: prev: {
                  treesitter-parsers = { };
                });
            })
          ];
        };

        distribution = lib.makeDistribution pkgs;
      in
      {
        packages = {
          config = lib.makeLuaConfig pkgs;
          default = distribution;
        };

        apps.default = {
          type = "app";
          program = "${distribution}/bin/nvim";
        };

        formatter = pkgs.nixpkgs-fmt;
      }
    );
}
