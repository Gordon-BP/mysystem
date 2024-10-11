# Utilities that get information about the computer & hardware
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neofetch
    onefetch
    ipfetch
    cpufetch
    nvitop # GPU resource tracker
    bottom
    kmon
    wlr-randr
    dig
    speedtest-rs
  ];
}
