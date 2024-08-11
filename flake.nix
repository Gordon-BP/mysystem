{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-24.05 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
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
       ./usrModules/lsp.nix
       ./usrModules/terminal-utils.nix
       ./usrModules/theme.nix
       ./usrModules/virtualisation.nix
        ];
    };
  };
}
