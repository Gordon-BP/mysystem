# Programming languages, language server protocols (LSP)
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
     go
    lua
    luarocks
    nodePackages_latest.nodejs
    nodePackages_latest.pnpm
    nodePackages_latest.nodemon
    nodePackages_latest.typescript
    nodePackages_latest.typescript-language-server
     poetry
     pyright
     python312Full
     python312Packages.pip
  ];  
}
