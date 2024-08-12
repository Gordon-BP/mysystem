# Hyprland settings, declaratively!

{
  lib,
  username,
  host,
  config,
  ...
}:

let

in
with lib;
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
};
}

