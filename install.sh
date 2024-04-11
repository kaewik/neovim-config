#!/usr/bin/env bash
set -ex
nix_profile_list=$(nix profile list --json)
if [ -z "$nix_profile_list" ]; then
    neovim_store_paths=$(nix profile list --json | jq -r '.elements[] | select(.originalUrl | contains("neovim")) | .storePaths[]')
    while IFS= read -r neovim_store_paths; do
        nix profile remove $neovim_store_paths
    done <<< "$neovim_store_paths"
fi
nix profile install .#neovim
