# System services and utilities
{ pkgs, ... }:

{
  
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
  # services.gnome.core-shell.enable = true;
  # services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  environment.systemPackages = with pkgs; [
    at-spi2-atk # Assistive tech / accessibility
    cliphist # Wayland clipboard mngr
    curl # API Calls from terminal
    dunst # Notification util
    ffmpeg_6-full # Sound compression lib
    gcc # C compiler - deoendancy for many pkgs
    git # Source control
    gh # Github
    gnumake42 # make, also some kind of compiler IIRC
    grimblast # Screenshot util
    libxkbcommon # C compiler
    networkmanagerapplet # Gnome network manager gui
    nwg-look # GTK3 Settings editor
    psi-notify # alert on system resource saturation
    playerctl # control media players with command line
    poppler_utils # PDF Rendering Library
    psmisc # A set of small useful utilities that use the proc filesystem
    pulseaudio # Sound server
    qt6.qtwayland
    ueberzug # Image preview tools
    usbutils # USB ports
    waybar # Application dock / status bars
    wget # CLI network call util
    wl-screenrec # Screen recording
    wl-clipboard # Clipboard management
    wl-clip-persist # Clipboard management
    wlrctl # Wayland extensions controls
    wtype # Xdotool type for wayland (?)
    wlogout # Wayland logout menu
    xdg-desktop-portal-hyprland # Needed utils for Hyprland
    xdg-utils # X server desktop integration
  ];
}
