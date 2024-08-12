
# Utilities that get information about the computer & hardware
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
     bitwarden-desktop # OSS Password manager with GUI
     bruno # OSS API Client, like Postman
     discord # Promote brain rot
     expressvpn # VPN service with good cli
     mpd # music player
     mpv # video player
     ollama # Local LLM server app
     opensnitch-ui # application-level firewall, like LuLu
     transmission_4 # OSS bittorrent
     zoom-us # Video conferencing
  ];
}
