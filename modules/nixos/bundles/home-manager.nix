# Stolen from https://github.com/vimjoyer/nixconf/blob/main/nixosModules/bundles/home-manager.nix
# I think this is where all the home manger configs go
# And maybe some macros?
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
  options.myNixOS = {
    userName = lib.mkOption {
      default = "gordy";
      description = ''
        username
      '';
    };

    userConfig = lib.mkOption {
      default = ./../../home-manager/work.nix;
      description = ''
        home-manager config path
      '';
    };

    userNixosSettings = lib.mkOption {
      default = {};
      description = ''
        NixOS user settings
      '';
    };
  };
  # Config options for ZSH, Hyperland
  config = {
    programs.zsh.enable = true;

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
      users = {
        ${cfg.userName} = {...}: {
          imports = [
            (import cfg.userConfig)
            outputs.homeManagerModules.default
          ];
        };
      };
    };

    users.users.${cfg.userName} =
      {
        isNormalUser = true;
        initialPassword = "12345";
        description = cfg.userName;
        shell = pkgs.zsh;
        extraGroups = ["libvirtd" "networkmanager" "wheel"];
      }
      // cfg.userNixosSettings;
  };
}
