
{config, pkgs, inputs, ...} : 
{
  programs.zsh = {
        enable = true;
        ohMyZsh = {
          enable = true;
          theme = "robbyrussell";
          plugins = [
            "sudo"
            "git"
            "vi-mode"
          ];
        };
      };

}
