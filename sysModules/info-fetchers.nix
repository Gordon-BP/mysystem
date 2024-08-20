# Utilities that get information about the computer & hardware
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neofetch
    onefetch
    ipfetch
    cpufetch
    ramfetch
    bottom
    btop
    kmon
    wlr-randr
    dig
    speedtest-rs
  ];
}
