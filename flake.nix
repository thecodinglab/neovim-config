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

      extraPathArgs = [ "--suffix" "PATH" ":" (nixpkgs.lib.makeBinPath deps) ];

      configs = pkgs.stdenv.mkDerivation {
        name = "neovim-configs";
        src = ./.;

        dontUseCmakeConfigure = true;

        installPhase = ''
          mkdir -p $out/
          cp -r init.lua lua $out/
        '';
      };

      makeWrappedNeovim = (package: pkgs.wrapNeovim package {
        # required for github copilot
        withNodeJs = true;

        extraMakeWrapperArgs = nixpkgs.lib.escapeShellArgs extraPathArgs;
        configure = {
          customRC = ''
            lua package.path = '${configs}/lua/?.lua;${configs}/lua/?/init.lua;' .. package.path
            luafile ${configs}/init.lua

            lua vim.opt.runtimepath:remove(vim.fn.stdpath('config'))
          '';
        };
      });

      neovimPrebuilt = makeWrappedNeovim pkgs.neovim-unwrapped;
      neovimCustom = makeWrappedNeovim neovim.packages.${system}.neovim;
    in
    {
      packages = rec {
        prebuilt = neovimPrebuilt;
        custom = neovimPrebuilt;

        default = prebuilt;
      };

      apps = rec {
        prebuilt = {
          type = "app";
          program = "${neovimPrebuilt}/bin/nvim";
        };

        custom = {
          type = "app";
          program = "${neovimCustom}/bin/nvim";
        };

        default = prebuilt;
      };

      formatter = pkgs.nixpkgs-fmt;
    }
  );
}
