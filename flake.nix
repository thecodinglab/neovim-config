{
  description = "personal neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    neovim = {
      url = "github:neovim/neovim?dir=contrib";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };

  outputs = { self, nixpkgs, flake-utils, neovim }:
    let
      lib = rec {
        makeLuaConfig = (pkgs: pkgs.stdenv.mkDerivation {
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

            extraPathArgs = [ "--suffix" "PATH" ":" (pkgs.lib.makeBinPath deps) ];
            luaConfig = makeLuaConfig pkgs;

            distribution = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped {
              wrapRc = false;
              withPython3 = false;

              wrapperArgs = extraPathArgs;
              packpathDirs = {
                myNeovimPackages = {
                  start = [ luaConfig ];
                  opt = [ ];
                };
              };
            };
          in
          distribution);
      };
    in
    lib //
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;

          overlays = [
            neovim.overlay
            (final: prev: {
              neovim-unwrapped = prev.neovim-unwrapped.override {
                treesitter-parsers = { };
              };
            })
          ];

          config.permittedInsecurePackages = [
            "nix-2.16.2"
          ];
        };

        distribution = lib.makeDistribution pkgs;
      in
      {
        packages = rec {
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
