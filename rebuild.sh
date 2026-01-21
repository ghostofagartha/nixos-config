#!/usr/bin/env bash
# /home/aori/.dotfiles/rebuild.sh

# 1. Format the code (optional, requires nixpkgs-fmt)
# nixpkgs-fmt *.nix

# 2. Add files to git (critical for Flakes)
git add .

# 3. Rebuild the system
sudo nixos-rebuild switch --flake ~/.dotfiles#nixos-btw

# 4. Commit and Push if rebuild was successful
if [ $? -eq 0 ]; then
  gen=$(nixos-rebuild list-generations | grep current | awk '{print $1}')
  git commit -m "Rebuild generation $gen"
  git push origin main
fi
