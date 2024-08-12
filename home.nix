{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  # home.username = "gordy";
  # home.homeDirectory = "/home/gordy";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  # home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home = {
    packages = with pkgs; [
      firefox
     #  ./sysModules/hyprland.nix
     # ./sysModules/info-fetchers.nix
     #  ./sysModules/nvidia.nix
     # ./sysModules/screen.nix
     # ./sysModules/services.nix
     # ./sysModules/zsh.nix
     #  # ./usrModules/gordy.nix
     #  ./usrModules/hyprland.nix
     # ./usrModules/lsp.nix
     # ./usrModules/otherPrograms.nix
     # ./usrModules/terminal-utils.nix
     # ./usrModules/theme.nix
     # ./usrModules/virtualisation.nix
    ];
    username = "gordy";
    homeDirectory = "/home/gordy";
    stateVersion = "24.05";
  };
}
