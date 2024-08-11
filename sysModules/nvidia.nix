
{config, pkgs, inputs, ...} : 
let

in
{
  # Enable OpenGL
  # in future nixos versions this is renamed to hardware.graphics
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      mesa # OSS 3D graphics
      nvidia-vaapi-driver # Video Accelleration API
      nv-codec-headers-12
    ];
  };
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
    };
  environment.variables = {
    # From the hyprland wiki; needed for nvidia graphics cards
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
  };
}
