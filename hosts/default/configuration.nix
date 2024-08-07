{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  system,
  myLib,
  hm,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  myNixOS = {
    bundles.general-desktop.enable = true;
    bundles.users.enable = true;
    sddm.enable = true;

    hyprland.enable = true;
    home-users = {
      "gordy" = {
        userConfig = ./home.nix;
        userSettings = {
          extraGroups = ["docker" "libvirtd" "networkmanager" "wheel" "adbusers"];
        };
      };
    };
  };
system.name = "work-nixos";
  system.nixos.label = "test1";

  security.sudo.wheelNeedsPassword = false;

  # boot.loader.systemd-boot.enable = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.extraModprobeConfig = ''
    options kvm_intel nested=1
    options kvm_intel emulate_invalid_guest_state=0
    options kvm ignore_msrs=1
  '';


  networking.hostName = "work";

 # Enable networking
  networking.networkmanager.enable = true;

  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    layout = "us";
    xkbVariant = "";
    libinput.enable = true;
  };

  hardware = {
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = true;
    bluetooth.enable = true;
    opengl = {
      enable = true;
      driSupport32Bit = true;
      driSupport = true;
      extraPackages = with pkgs; [
        vulkan-tools
        vulkan-headers
        vulkan-loader
        vulkan-validation-layers
        vulkan-tools-lunarg
      ];
    };
  };

  # hardware.nvidia.modesetting.enable = true;
  # environment.variables.WLR_NO_HARDWARE_CURSORS = "1";

  services.printing.enable = true;
  services.ratbagd.enable = true;
  services.usbmuxd.enable = true;
  services.avahi.enable = true;

  environment.systemPackages = with pkgs; [
    pciutils
    cifs-utils
    vulkan-tools
  ];

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
  xdg.portal.enable = true;
  programs.adb.enable = true;

  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;
  # virtualisation.docker.enableNvidia = true;

  services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true;
  services.flatpak.enable = true;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
