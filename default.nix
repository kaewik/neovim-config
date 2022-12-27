{ pkgs ? (import <nixpkgs> {}).pkgs, ... }:
pkgs.symlinkJoin {
  name = "nvim_kaewik";
  paths = [ pkgs.neovim ];
  buildInputs = [ pkgs.coreutils pkgs.makeWrapper ] ++ import ./dependencies.nix { pkgs = pkgs; };
  postBuild = ''
    echo "Builder Phase"
    export PATH="$coreutils/bin:$PATH"
    mkdir -p $out/.config/neovim
    cp -R $src/* $out/bin
    ls $out/.config/neovim
    wrapProgram $out/bin/nvim --add-flags "--cmd 'set rtp^=$out/bin' -u $out/bin/init.lua"
  '';
  src = pkgs.lib.sourceFilesBySuffices ./. [ ".lua" ];
}
