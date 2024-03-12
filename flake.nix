{
  description = "personal neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    # NOTE: the current version of nixd (1.2.3) uses an old version of nix,
    # which is vulnerable to CVE-2024-27297. This is a temporary workaround
    # until nixd is updated in the nixpkgs repository.
    nixd-nightly = {
      url = "github:nix-community/nixd";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, nixd-nightly }:
    let
      lib = rec {
        makeLuaConfig = (pkgs: pkgs.stdenv.mkDerivation {
          name = "neovim-lua-config";
          src = ./.;

          dontUseCmakeConfigure = true;

          installPhase = ''
            mkdir -p $out/
            cp -r init.lua lua $out/
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

              # gen.nvim
              pkgs.ollama
              pkgs.curl

              # coq_nvim
              pkgs.python3
              pkgs.sqlite

              # preinstalled lsp
              pkgs.ltex-ls
              pkgs.lua-language-server
              pkgs.nixd
              pkgs.nixpkgs-fmt
            ];

            extraPathArgs = [ "--suffix" "PATH" ":" (pkgs.lib.makeBinPath deps) ];

            luaConfig = makeLuaConfig pkgs;

            distribution = pkgs.wrapNeovim pkgs.neovim-unwrapped {
              # required for github copilot
              withNodeJs = true;

              extraMakeWrapperArgs = pkgs.lib.escapeShellArgs extraPathArgs;
              configure = {
                customRC = ''
                  lua package.path = '${luaConfig}/lua/?.lua;${luaConfig}/lua/?/init.lua;' .. package.path
                  luafile ${luaConfig}/init.lua
                '';
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
            (final: prev: {
              neovim-unwrapped = prev.neovim-unwrapped.override {
                treesitter-parsers = { };
              };

              nixd =
                (if prev.lib.getVersion prev.nixd == "1.2.3"
                then nixd-nightly.packages.${system}.nixd
                else prev.nixd);
            })
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
