from ghcr.io/nixos/nix

RUN printf "%s\n%s\n" "experimental-features = nix-command flakes" "$(cat /etc/nix/nix.conf)" > /etc/nix/nix.conf
RUN nix profile install nixpkgs#jq --impure
RUN mkdir /root/neovim-config
WORKDIR /root/neovim-config
COPY . /root/neovim-config
RUN ./install.sh
