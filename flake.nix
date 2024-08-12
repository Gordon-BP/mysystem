{
  description = "A simple NixOS flake";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit inputs; };
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        ./sysModules/firefox.nix
        ./sysModules/hyprland.nix
       ./sysModules/info-fetchers.nix
        ./sysModules/nvidia.nix
       ./sysModules/screen.nix
       ./sysModules/services.nix
       ./sysModules/zsh.nix
        ./usrModules/gordy.nix
        ./usrModules/hyprland.nix
       ./usrModules/lsp.nix
       ./usrModules/terminal-utils.nix
       ./usrModules/theme.nix
       ./usrModules/virtualisation.nix
        ];
      };

    };
  };
}
