
{config, pkgs, inputs, ...} : 
{
environment.systemPackages = with pkgs; [ 
oh-my-zsh
zsh
];
  #set to default values
  programs.direnv = {
    package = pkgs.direnv;
    silent = false;
    loadInNixShell = true;
    direnvrcExtra = "";
    nix-direnv = {
      enable = true;
      package = pkgs.nix-direnv;
    };
  };
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
        blog="cd ~/hanakano-website/content/posts/";
        fkn-login="gh auth token | gh auth login --with-token";
        start-llama-server=" llama-server -m ~/models/qwen2.5-coder-1.5b-q8_0.gguf --port 8012 -ngl 99 -fa -ub 1024 -b 1024 --ctx-size 0 --cache-reuse 256";
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
