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

        config = pkgs.callPackage ./nix/config.nix { };

        distribution = pkgs.callPackage ./nix/distribution.nix {
          custom-config = config;
          preinstalled-lsp = [
            pkgs.ltex-ls
            pkgs.lua-language-server
            pkgs.nixd
            pkgs.nixpkgs-fmt
            pkgs.gopls

            pkgs.nodePackages.typescript-language-server
            pkgs.vscode-langservers-extracted
          ];
        };
      in
      {
        packages = {
          config = config;
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
