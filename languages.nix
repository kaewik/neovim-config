
{ pkgs ? (import <nixpkgs> {}).pkgs, ... }:
with pkgs; [
  # typescript
  nodejs-18_x
  nodePackages.typescript
  nodePackages.typescript-language-server
  nodePackages.vscode-langservers-extracted

  # rust
  rust-analyzer
  rustup

  # c++
  cmake
  clangStdenv

  # haskell
  ghc
  haskellPackages.haskell-language-server

  # c#
  omnisharp-roslyn
  dotnet-sdk
]