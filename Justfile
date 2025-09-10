set shell := ["bash", "-c"]

# List all the just commands
default:
    @just --list

# Build
[group('nix')]
build:
  nix build --no-link . --print-build-logs --show-trace -L --verbose --option substituters "https://mirrors.ustc.edu.cn/nix-channels/store  https://cache.nixos.org/"



# Nix develop
[group('nix')]
develop flake=".#default":
  # pure shell: 
  # - https://github.com/NixOS/nix/issues/6439#issuecomment-1107619941
  # - https://discourse.nixos.org/t/nix-develop-fails-with-command-bash-norc/31896/9
  nix develop --ignore-environment --keep HOME . --command bash --noprofile --norc

# Update all the flake inputs
[group('nix')]
up:
  nix flake update --commit-lock-file -L --show-trace --verbose