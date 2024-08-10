# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./sysModules/nvidia.nix
      ./sysModules/firefox.nix
      ./sysModules/zsh.nix
    ];

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];
  hardware.opengl.enable = true;
  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes" ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable Hyprland window manager
  programs.hyprland.enable = true;

  # Bluetooth enable
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Singapore";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_SG.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_SG.UTF-8";
    LC_IDENTIFICATION = "en_SG.UTF-8";
    LC_MEASUREMENT = "en_SG.UTF-8";
    LC_MONETARY = "en_SG.UTF-8";
    LC_NAME = "en_SG.UTF-8";
    LC_NUMERIC = "en_SG.UTF-8";
    LC_PAPER = "en_SG.UTF-8";
    LC_TELEPHONE = "en_SG.UTF-8";
    LC_TIME = "en_SG.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
      };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gordy = {
    isNormalUser = true;
    description = "gordy";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
     bitwarden-desktop
     bruno
     expressvpn
     glow
     go
     llm
     luarocks
     mpd
     mpv
     nodejs_22
     ollama
     opensnitch-ui
     poetry
     pyright
     python312Full
     python312Packages.pip
     transmission_4
     typescript
     zoom-us
    ];
  };

  # Configure express vpn
  services.expressvpn.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true; 

  programs.firefox.enable = true;
  programs.zsh.enable = true;
  # List packages installed in system profile. To search, run: $ nix search wget 

  environment.systemPackages = with pkgs; [ 
  # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default. wget 
  blueman # GTK
  bluez # Bluetooth protocol
  dolphin # File manager
  fd # OSS Find
  gcc # C compiler - deoendancy for many pkgs
  git # Source control
  gh # Github
  gnumake42 # make, also some kind of compiler IIRC
  imv # Image viewer
  # Hyprland ecosystem utils
  hyprcursor
  hyprlock
  hypridle
  hyprpaper
  hyprpicker
  kitty # GPU-accelerated terminal emulator
  lf # terminal-based file explorer
  libxkbcommon # C compiler
  mesa # OSS 3D graphics
  neofetch # System info util
  neovim # Text editor
  networkmanagerapplet # Gnome network manager gui
  oh-my-zsh # ZSH plugins
  ripgrep # Text search util
  sqlite # In-memory database
  tofi # App launcher for wayland
  tree
  tree-sitter # Parsing util
  unzip # compression util
  waybar # UI bar for wayland
  xdg-desktop-portal-hyprland # Needed utils for Hyprland
  zsh # Shell language
  ];

  environment.variables = {
    EDITOR = "nvim";
    # From the hyprland wiki; needed for nvidia graphics cards
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "true";
    };

  services.blueman.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
