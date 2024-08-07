# I have no idea why this file exists
# But it seems important

{inputs, ...}: {
  nix.registry = {
    n.flake = inputs.nixpkgs;
    u = {
      from = {
        id = "u";
        type = "indirect";
      };
      to = {
        owner = "nixos";
        repo = "nixpkgs";
        ref = "nixos-unstable";
        type = "github";
      };
    };
  };
}
