# User-lever 
{
  inputs,
  outputs,
  pkgs,
  lib,
  ...
}: {
  myHomeManager = {
    bundles.general.enable = true;
    bundles.desktop-full.enable = true;

    monitors = {
      "HDMI-1" = {
        width = 2560;
        height = 1440;
        refreshRate = 60;
        x = 0;
        y = 0;
      };
      "HDMI-2" = {
        width = 1920;
        height = 1080;
        refreshRate = 60.;
        x = 2560;
        y = 430;
	rotation="right";
      };
    };
  };
  home = {
    stateVersion = "24.05";
    homeDirectory = lib.mkDefault "/home/gordy";
    username = "gordy";

    ackages = with pkgs; [
      bottles
      libimobiledevice
      ifuse
      (unityhub.override
        {
          extraLibs = pkgs:
            with pkgs; [
              openssl_1_1
            ];
        })
    ];
  };
}
