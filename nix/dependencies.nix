{ pkgs ? (import <nixpkgs> {}).pkgs, ... }:
with pkgs; [
  # general
  bat
  fd
  neovim
  ripgrep
  git
  delta
  fzf
  gcc # needed for tree-sitter
]
