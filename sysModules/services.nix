# System services and utilities
{ pkgs, ... }:

{
  # Systemd services setup
  systemd.packages = with pkgs; [
    auto-cpufreq
  ];
  
  # Enable Services
  services.geoclue2.enable = true;
  programs.direnv.enable = true;
  services.upower.enable = true;
  programs.fish.enable = true;
  programs.dconf.enable = true;
  services.dbus.enable = true;
  services.dbus.packages = with pkgs; [
  	xfce.xfconf
  	gnome2.GConf
  ];
  services.mpd.enable = true;
  services.tumbler.enable = true; 
  services.fwupd.enable = true;
  services.auto-cpufreq.enable = true;
  # services.gnome.core-shell.enable = true;
  # services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  environment.systemPackages = with pkgs; [
    at-spi2-atk
    avizo
    cliphist
    curl
    dunst
    ffmpeg_6-full
    gcc # C compiler - deoendancy for many pkgs
    git # Source control
    gifsicle
    gh # Github
    gnumake42 # make, also some kind of compiler IIRC
    libxkbcommon # C compiler
    networkmanagerapplet # Gnome network manager gui
    psi-notify
    playerctl
    poweralertd
    psmisc
    qt6.qtwayland
    usbutils
    waybar
    wget
    wl-screenrec
    wl-clipboard
    wl-clip-persist
    wlrctl
    wtype
    wlogout
    xdg-desktop-portal-hyprland # Needed utils for Hyprland
    xdg-utils
  ];
}
