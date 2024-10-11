{ pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  environment.systemPackages = with pkgs; [
    pyprland # Hyprland plugins
    hyprpicker # color picker
    hyprcursor # Cursor driver
    hyprlock # Lock screen
    hypridle # Idle locker
    hyprpaper # Wallpaper util
    wofi-emoji # Emoji picker
    mpv # Media player
    imv # Image viewer
  ];
}
