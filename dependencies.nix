{ pkgs ? (import <nixpkgs> {}).pkgs, ... }:
with pkgs; [
  # general
  bat
  fd
  neovim
  ripgrep

  # typescript
  nodejs-18_x
  nodePackages.typescript
  nodePackages.typescript-language-server
  nodePackages.vscode-langservers-extracted

  # rust
  rust-analyzer
  rustup

  # c++
  gcc
  cmake
  llvm

  # haskell
  ghc
  haskellPackages.haskell-language-server
]
