
{config, pkgs, inputs, ...} : 
{
environment.systemPackages = with pkgs; [ 
oh-my-zsh
zsh
];
  programs.direnv.enable = true; # Nix dev containers in directories
  programs.zsh = {
        enable = true;
        ohMyZsh = {
          enable = true;
          theme = "alanpeabody";
          plugins = [
            "direnv"
            "git"
            "sudo"
            "vi-mode"
          ];
        };
      shellAliases = {
        new_llama="_new_l370 '$*'";
        llama="_l370 '$*'";
        nrs = "nixos-rebuild switch --flake ~/mysystem#nixos";
        nenv-list = "nix-env --list-generations --profile /nix/var/nix/profiles/system";
        nenv-delete = "nix-env --delete-generations --profile /nix/var/nix/profiles/system";
        helpme = "mdcat ~/.config/help.md";
        morpho="cd ~/Documents/project-butterfly/src/morpho/";
        blog="cd ~/hanakano-website/content/posts/";
        fkn-login="gh auth token | gh auth login --with-token";
      };
      interactiveShellInit = ''
        function _l370(){ 
          llm --continue --template llama70b "$*" | glow -
        }
        function show_help {
          print -P "%F{cyan} say 'helpme' if you are confused...%f"
        }
      '';
      promptInit = ''
      show_help
      '';
      };

}
