# NeoVim Configuration by Nix Flakes

This is configuration is powered by this awesome [neovim-flake](https://github.com/jordanisaacs/neovim-flake).
Still, it is based on my own fork, s.th. I have the freedom to change things, see [my neovim-flake fork](https://github.com/kaewik/neovim-flake).

## Prerequisites

- nix package manager
- jq
- /etc/nix.conf needs to have the following line:
```
experimental-features = nix-command flakes
```

## How to install?

Just run `./install.sh`.

## How to update the neovim-flake?

Just run `nix flake lock --update-input neovim-flake`
