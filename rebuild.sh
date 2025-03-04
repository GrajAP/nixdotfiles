#!/bin/bash
set -e
cd /etc/nixos/
git pull
# Autoformat your nix files
alejandra /etc/nixos/ &>/dev/null \
  || ( alejandra /etc/nixos/ ; echo "formatting failed!" && exit 1)

echo "NixOS Rebuilding..."

nh os switch --update
nh clean all --keep 3

# Get current generation metadata
current=$(nixos-rebuild list-generations | grep current)
git add *
git commit -am "$current"
echo "Rebuild finished"
# git push
# Commit all changes witih the generation metadata
