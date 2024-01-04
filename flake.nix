{
  description = "personal neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    neovim = {
      url = "github:neovim/neovim/stable?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, neovim }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };

      deps = with pkgs; [
        # required to fetch plugins
        git

        # required to build native libraries for things like treesitter
        # or nvim-telesceope-fzf-native
        gcc
        gnumake
        cmake

        # required for fuzzy finding in telescope
        fd
        silver-searcher
      ];

      extraPathArgs = nixpkgs.lib.lists.flatten
        (builtins.map
          (pkg: [ "--prefix" "PATH" ":" "${pkg}/bin" ])
          deps);

      configs = pkgs.stdenv.mkDerivation {
        name = "neovim-configs";
        src = ./.;

        dontUseCmakeConfigure = true;

        installPhase = ''
          mkdir -p $out/
          cp -r init.lua lua $out/
        '';
      };

      # NOTE: change to `pkgs.neovim-unwrapped` when you don't want to build
      # neovim on your own machine.
      neovim-package = neovim.packages.${system}.neovim;

      wrapped = pkgs.wrapNeovim neovim-package {
        extraMakeWrapperArgs = nixpkgs.lib.escapeShellArgs extraPathArgs;
        configure = {
          customRC = ''
            lua package.path = '${configs}/lua/?.lua;${configs}/lua/?/init.lua;' .. package.path
            luafile ${configs}/init.lua
          '';
        };
      };
    in
    {
      packages.default = wrapped;

      apps.default = {
        type = "app";
        program = "${wrapped}/bin/nvim";
      };

      formatter = pkgs.nixpkgs-fmt;
    }
  );
}
