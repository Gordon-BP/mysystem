# Defines things needed for MS Azure applications
{ lib, pkgs, ... }:
let
  azure-cli = pkgs.azure-cli.withExtensions [
      pkgs.azure-cli.extensions.ssh
      pkgs.azure-cli.extensions.bastion
    ];
  in
{


  environment.systemPackages = with pkgs; [
     python312Packages.msal
     python312Packages.msal-extensions
     azure-cli # MS Azure cli utility
    ];

}
