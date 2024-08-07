{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.myHomeManager;

  pimg = pkgs.writeShellScriptBin "pimg" ''
    output="out.png"
    [ ! -z "$1" ] && output="$1.png"
    # xclip -se c -t image/png -o > "$output"
    ${pkgs.wl-clipboard}/bin/wl-paste > "$output"
  '';

in {
  home.file = {
    # ZSH plugins go here?
    ".local/share/zsh/zsh-autosuggestions".source = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
    # ".local/share/zsh/zsh-fast-syntax-highlighting".source = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
    # ".local/share/zsh/nix-zsh-completions".source = "${pkgs.nix-zsh-completions}/share/zsh/plugins/nix";
    # ".local/share/zsh/zsh-vi-mode".source = "${pkgs.zsh-vi-mode}/share/zsh-vi-mode";
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    dotDir = ".config/zsh";
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza --icons -a --group-directories-first";
      tree = "${pkgs.eza}/bin/eza --color=auto --tree";
      grep = "grep --color=auto";
      q = "exit";
      llama = "stream_with_glow llama70b true";
      new_llama = "stream_with_glow llama70b false";
      gpt = "stream_with_glow gpt4o true";
      new_gpt = "stream_with_glow gpt4o false";
      claude = "stream_with_glow claude true";
      new_claude = "stream_with_glow claude false";
    };
  };

    # Oh my ZSH setting
    oh-my-zsh = {
	enable = true;
	theme = "robbyrussell";
	plugins = ["git"];
    };
  # Can treat this like your .zshrc file
  programs.zsh.initExtra = ''
setopt +o nomatch

zstyle ":omz:update:" mode auto
zstyle ":omz:update" frequency 14

HIST_STAMPS="yyyy.mm.dd"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"

function stream_with_glow() {
	local template="$1"
	local continue_flag="$2"
	shift 2

	if ["$continue_flag" = "true" ]; then
		llm prompt --continue --template "$template" "$@" | glow -
	else
		llm prompt --template "$template" "$@" | glow -
	fi
    if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
    else
	exort EDITOR='nvim'
    fi
  '';

  programs.zsh.envExtra = ''
    export EDITOR="nvim"
    export TERMINAL="alacritty"
    export TERM="alacritty"
    export BROWSER="firefox"
    export VIDEO="vlc"
    export IMAGE="imv"
    export OPENER="xdg-open"
    export SCRIPTS="$HOME/scripts"
    export LAUNCHER="rofi -dmenu"
    export FZF_DEFAULT_OPTS="--color=16"

    # Less colors
    export LESS_TERMCAP_mb=$'\e[1;32m'
    export LESS_TERMCAP_md=$'\e[1;32m'
    export LESS_TERMCAP_me=$'\e[0m'
    export LESS_TERMCAP_se=$'\e[0m'
    export LESS_TERMCAP_so=$'\e[01;33m'
    export LESS_TERMCAP_ue=$'\e[0m'
    export LESS_TERMCAP_us=$'\e[1;4;31m'
    export vimcolorscheme="gruvbox"

    # direnv
    export DIRENV_LOG_FORMAT=""
  '';

  home.packages = [
    pimg

    (pkgs.writeShellScriptBin "mk" ''
      mkdir -p $( dirname "$1") && touch "$1"
    '')
  ];
}
