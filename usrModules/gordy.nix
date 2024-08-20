# Defines Gordy user and their packages
{ lib, pkgs, ... }:
let
  azure-cli = pkgs.azure-cli.withExtensions [
      pkgs.azure-cli.extensions.ssh
      pkgs.azure-cli.extensions.bastion
    ];
in
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gordy = {
    isNormalUser = true;
    description = "gordy";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
     azure-cli # MS Azure cli utility
     bitwarden-desktop # OSS Password manager with GUI
     bruno # OSS API Client, like Postman
     catppuccin # Pastel theme
     catppuccin-cursors.macchiatoTeal # Cursor pack
     catppuccin-gtk # Catppuccin theme for GNOME
     discord # Promote brain rot
     expressvpn # VPN service with good cli
     hugo # Website build util
     llama-cpp # Run LLMs locally
     llm # frontend for talking to llms locally
     mpd # music player
     mpv # video player
     ngrok # Expose local ports to the internet
     ollama # Local LLM server app
     opensnitch-ui # application-level firewall, like LuLu
     ruff # python linter
     transmission_4 # OSS bittorrent
     vimPlugins.catppuccin-nvim # Catpuccin theme for neovim
     zoom-us # Video conferencing
    ];
  };

  # Configure express vpn
  services.expressvpn = {
     enable = true;
     };

  # Github info
  environment.variables = {
    GIT_AUTHOR_NAME = "Gordon-BP";
    GIT_AUTHOR_EMAIL = "gordynumberone@protonmail.com";
  };

  # Change runtime directory size
  # services.logind.extraConfig = "RuntimeDirectorySize=8G";
}
