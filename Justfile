set shell := ["bash", "-c"]

# List all the just commands
default:
    @just --list

# Build
[group('nix')]
build:
  nix build --no-link . --print-build-logs --show-trace -L --verbose --option substituters "https://mirrors.ustc.edu.cn/nix-channels/store  https://cache.nixos.org/"

[group('nix')]
develop:
  nix develop -i . --command bash --noprofile --norc

# Update all the flake inputs
[group('nix')]
up:
  nix flake update --commit-lock-file -L --show-trace --verbose