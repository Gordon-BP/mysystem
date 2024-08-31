# Utilities that get information about the computer & hardware
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neofetch
    onefetch
    ipfetch
    cpufetch
    ramfetch
    nvitop # GPU resource tracker
    bottom
    btop
    kmon
    wlr-randr
    dig
    speedtest-rs
  ];
}
