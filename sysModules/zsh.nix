
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
          theme = "alanpeabody";
          plugins = [
            "sudo"
            "git"
            "vi-mode"
          ];
        };
      shellAliases = {
        new_llama="_new_l370 '$*'";
        llama="_l370 '$*'";
      };
      interactiveShellInit = ''
        function _l370(){ 
          llm --continue --template llama70b "$*" | glow -
        }
      '';
      promptInit = ''
        eval 'gh auth token | gh auth login --with-token'
        eval "$(zoxide init zsh)"
      '';
      };

}
