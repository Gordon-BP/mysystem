# Defines Gordy user and their packages
{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gordy = {
    isNormalUser = true;
    description = "gordy";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
     bitwarden-desktop # OSS Password manager with GUI
     # bruno # OSS API Client, like Postman
     # discord # Promote brain rot
     # expressvpn # VPN service with good cli
     # mpd # music player
     # mpv # video player
     # ollama # Local LLM server app
     # opensnitch-ui # application-level firewall, like LuLu
     # transmission_4 # OSS bittorrent
     # zoom-us # Video conferencing
    ];
  };

  # Configure express vpn
  # services.expressvpn = {
  #   enable = true;
  #   };

  # Github info
  environment.variables = {
    GIT_AUTHOR_NAME = "Gordon-BP";
    GIT_AUTHOR_EMAIL = "gordynumberone@protonmail.com";
  };

  # Change runtime directory size
  # services.logind.extraConfig = "RuntimeDirectorySize=8G";
}
