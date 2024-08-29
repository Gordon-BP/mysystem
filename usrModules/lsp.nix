# Programming languages, language server protocols (LSP)
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
     go # Go programming language
     gopls # Go LSP
    lua # Lua programming language
    luarocks # Lua package manager
    nodePackages_latest.nodejs # Hot garbage
    nodePackages_latest.pnpm # Hotter garbage
    nodePackages_latest.nodemon # Hot garbage runtime
    nodePackages_latest.typescript # Typescript language
    nodePackages_latest.typescript-language-server # Typescript LSP
     poetry # Python venv manager
     pyright # Python LSP
     python312Full # Python programming language
     python312Packages.pip # Python package manager
  ];  
}
