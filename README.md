# COMMON COMMANDS

NixOS is a _complicated fucking system_ but it is totally possible for you to do it. To help you along, here are step-by-step of common tasks you do.

## Updating Your System Packages

1. Pull the latest updates from nixpkgs-unstable

`sudo nix flake update --commit-lock-file`

2. Rebuild your system

`sudo nixos-rebuild switch --flake .`

3. Take out the garbage

`sudo nix-collect-garbage -d`

## Adding a new package

1. Pull the latest updates from nixpkgs-unstable

`sudo nix flake update --commit-lock-file`

2. Search for the package

`nix search <package-name>`

3. Once you find it, add it to one of the files in ./usrModules. If in doubt, add it to ./usrModules/gordy.nix

4. Rebuild your system

`sudo nixos-rebuild switch --flake .`

5. Take out the garbage

`sudo nix-collect-garbage -d`

## Updating a package on nixpkgs

See ./UPDATING_NIXPKGS.md and God Help You.

## Rolling Back

