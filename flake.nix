{
  description = "personal neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    neovim-src = {
      url = "github:neovim/neovim";
      flake = false;
    };
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        neovim-src.follows = "neovim-src";
      };
    };
  };

  outputs = { self, nixpkgs, neovim-nightly, ... }:
    let
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in {
          config = pkgs.runCommand "neovim-config" { } "cp -r ${./.} $out/";

          default = pkgs.callPackage ./nix/distribution.nix {
            neovim-unwrapped = neovim-nightly.packages.${system}.default.overrideAttrs (final: prev: {
              treesitter-parsers = { };
            });

            custom-config = self.packages.${system}.config;

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
        });

      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/nvim";
        };
      });

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);
    };
}
