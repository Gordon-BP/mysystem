# Defines things needed for MS Azure applications
{ lib, pkgs, ... }:
let
  nixpkgs.config.packageOverrides = super: {
      # nix-shell -p python.pkgs.msal
      python = super.python.override {
        # Careful, we're using a different self and super here!
        packageOverrides = python-self: python-super: {
          msal = python-super.msal.overridePythonAttrs (oldAttrs: {
              src = super.fetchPypi {
                pname = "msal";
                version = "1.30.0";
                hash = "sha256-tL8AhQCS5GUVfYFO+iShj3iChMmkeUkQJNYpAwheovs=";
              };
            });
          };
        };
      };
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
