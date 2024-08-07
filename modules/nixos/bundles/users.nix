# Taken from https://github.com/vimjoyer/nixconf/blob/main/nixosModules/bundles/users.nix
# I think this manages users and default user accounts. It looks very similar to home-manager.nix but it's not!
{
  lib,
  config,
  inputs,
  outputs,
  myLib,
  pkgs,
  ...
}: let
  cfg = config.myNixOS;
in {
  options.myNixOS.home-users = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        userConfig = lib.mkOption {
          default = ./../../home-manager/work.nix;
          example = "DP-1";
        };
        userSettings = lib.mkOption {
          default = {};
          example = "{}";
        };
      };
    });
    default = {};
  };

  config = {
    programs.zsh.enable = true;
    programs.fish.enable = true;

    programs.hyprland.enable = cfg.hyprland.enable;

    services.xserver = lib.mkIf cfg.hyprland.enable {
      displayManager = {
        defaultSession = "hyprland";
      };
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = {
        inherit inputs;
        inherit myLib;
        outputs = inputs.self.outputs;
      };

      users =
        builtins.mapAttrs (name: user: {...}: {
          imports = [
            (import user.userConfig)
            outputs.homeManagerModules.default
          ];
        })
        (config.myNixOS.home-users);
    };

    users.users = builtins.mapAttrs (
      name: user:
        {
          isNormalUser = true;
          initialPassword = "wikipedia";
          description = "";
          shell = pkgs.fish;
          extraGroups = ["libvirtd" "networkmanager" "wheel"];
        }
        // user.userSettings
    ) (config.myNixOS.home-users);
  };
}
