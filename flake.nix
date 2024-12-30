{
  description = "Gordy's work computer flake";

  inputs = {
    # Specify the source of and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "path:/home/gordy/nixpkgs";
    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs,ghostty, ... }@inputs:
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
        ./usrModules/azure.nix
        ./usrModules/databases.nix
        ./usrModules/gordy.nix
        ./usrModules/hyprland.nix
       ./usrModules/lsp.nix
       ./usrModules/terminal-utils.nix
       ./usrModules/theme.nix
       ./usrModules/virtualisation.nix
        ];
      };
    };
}
