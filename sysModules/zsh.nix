
{config, pkgs, inputs, ...} : 
{
environment.systemPackages = with pkgs; [ 
oh-my-zsh
zsh
];
  programs.zsh = {
        enable = true;
        ohMyZsh = {
          enable = true;
          theme = "dpoggi";
          plugins = [
            "sudo"
            "git"
            "vi-mode"
          ];
        };
      };

}
