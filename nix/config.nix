{ stdenv, ... }: stdenv.mkDerivation {
  name = "neovim-lua-config";
  src = ./..;

  dontUseCmakeConfigure = true;

  installPhase = ''
    cp -r . $out/
  '';
}
