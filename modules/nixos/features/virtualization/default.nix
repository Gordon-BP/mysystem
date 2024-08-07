# Taken from https://github.com/vimjoyer/nixconf/blob/main/nixosModules/features/virtualisation/default.nix
# I think these are default settings if we ever need to run a VM
{
  config,
  lib,
  ...
}: let
  cfg = config.myNixOS;
in {
  options.myNixOS = {
    altIsSuper = lib.mkEnableOption "switch super to alt";
  };

  config = {
    virtualisation.vmVariant = {
      myNixOS.altIsSuper = true;
      services.sshd.enable = true;
      virtualisation = {
        memorySize = 4096;
        cores = 4;
        qemu.options = [
          "-device virtio-vga-gl"
          "-display sdl,gl=on,show-cursor=off"
          "-audio pa,model=hda"
        ];
        sharedDirectories = {
          primary = {
            source = "/mnt/shared";
            target = "/mnt/shared";
          };
        };
      };
    };
  };
}
