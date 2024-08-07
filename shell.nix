# Stolen from https://github.com/vimjoyer/nixconf/blob/main/shell.nix
# I think this ensures that nix always has home manager, git, and neovim available
{pkgs ? (import ./nixpkgs.nix) {}}: {
  default = pkgs.mkShell {
    NIX_CONFIG = "experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [nix home-manager git neovim];
  };
}
