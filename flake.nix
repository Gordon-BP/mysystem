{
  description = "Home Manager configuration of gordy";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
    };
    persist-retro.url = "github:Geometer1729/persist-retro";
    nix-colors.url = "github:misterio77/nix-colors";
    stylix.url = "github:danth/stylix";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = {nixpkgs, ... }@inputs:
    # Stolen from https://github.com/vimjoyer/nixconf/blob/main/flake.nix
    # Reduces boilerplate by defining common functions elsewhere
    let
    _ = builtins.trace ''Hello world'';
    myLib = import ./myLib/default.nix {inherit inputs;};
    in 
      with myLib; {
	nixosConfigurations = {
	  # Add any future configs here
	  # Can be for a different profile (wife mode) or VPS or anything!
	  work = mkSystem ./hosts/default/configuration.nix;
	};
	homeConfigurations = {
	  # I think these are specific user configs for a given system
	  "gordy@work" = mkHome "x86_64-linux" ./hosts/default/home.nix;
	};
	homeManagerModules.default = ./modules/home-manager;
	nixosModules.default = ./modules/nixos;

      };
}
