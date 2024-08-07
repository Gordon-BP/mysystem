# Taken from https://github.com/vimjoyer/nixconf/blob/main/nixosModules/bundles/general-desktop.nix
# I believe this configures the baseline user desktop
{
  pkgs,
  lib,
  ...
}@inputs: {
  myNixOS.sddm.enable = lib.mkDefault false;
  myNixOS.autologin.enable = lib.mkDefault true;
  myNixOS.virtualization.enable = lib.mkDefault true;
  myNixOS.stylix.enable = lib.mkDefault true;

  # Kuala Lumpur time zone and date formatting
  time.timeZone = "Asia/Kuala Lumpur";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_UK.UTF-8";
    LC_IDENTIFICATION ="en_UK.UTF-8";
    LC_MEASUREMENT = "en_UK.UTF-8";
    LC_MONETARY = "en_UK.UTF-8";
    LC_NAME = "en_UK.UTF-8";
    LC_NUMERIC = "en_UK.UTF-8";
    LC_PAPER = "en_UK.UTF-8";
    LC_TELEPHONE = "en_UK.UTF-8";
    LC_TIME = "en_UK.UTF-8";
  };

  # Enable sound with pipewire.
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Override to add new font
  fonts.packages = with pkgs; [
    (pkgs.nerdfonts.override {fonts = ["JetBrainsMono" "Iosevka" "FiraCode"];})
    cm_unicode
    corefonts
  ];

  # fonts.enableDefaultPackages = true;
  # fonts.fontconfig = {
  #   defaultFonts = {
  #     monospace = ["JetBrainsMono Nerd Font Mono"];
  #     sansSerif = ["JetBrainsMono Nerd Font"];
  #     serif = ["JetBrainsMono Nerd Font"];
  #   };
  # };

  # battery
  services.upower.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  # services.gnome = {
  #   enable = true;
  #   # Configure GNOME settings, e.g., themes, extensions, etc.
  # };

  hardware.opengl.enable = true;
  
  # Nvidia drivers
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = inputs.config.boot.kernelPackages.nvidiaPackages.stable;
};
}
