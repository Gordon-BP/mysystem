# stolen from https://github.com/vimjoyer/nixconf/blob/main/nixpkgs.nix
# I think this ensures we are using the latest nixpkgs archive?
let
  lock = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
in
  import (fetchTarball {
    url = "https://github.com/nixos/nixpkgs/archive/${lock.rev}.tar.gz";
    sha256 = lock.narHash;
  })
