# Taken from https://github.com/vimjoyer/nixconf/blob/main/nixosModules/features/power-management.nix
# I think this applies mostly to laptops but I'm taking no chances
{...}: {
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };

  powerManagement.powertop.enable = true;

  services = {
    thermald.enable = true;
    auto-cpufreq.enable = true;
    upower.enable = true;
  };
}
