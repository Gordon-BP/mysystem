
{config, pkgs, inputs, ...} : 
let

in
{
  # Enable OpenGL
  # in future nixos versions this is renamed to hardware.graphics
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      cudatoolkit # CUDA packages 
      mesa # OSS 3D graphics
      nvidia-vaapi-driver # Video Accelleration API
      nv-codec-headers-12
      pciutils # Inspect & config PCI devices
    ];
  };
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];
  # Uses nvidia-smi to monitor GPU after boot
  systemd.services.nvidia-control-devices = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
  };
  # Enable CUDA
  nixpkgs.config.cudaSupport = true;
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  environment.variables = {
    # From the hyprland wiki; needed for nvidia graphics cards
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
  };
}
