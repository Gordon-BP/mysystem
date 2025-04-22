# Programming languages, language server protocols (LSP)
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
      bun # JS Runtime
      go # Go programming language
      gopls # Go LSP
      lua # Lua programming language
    lua-language-server # Lua LSP
      luarocks # Lua package manager
      node2nix # Tool to convert npm pkgs to nix
      nodePackages_latest.nodejs # Hot garbage
      nodePackages_latest.pnpm # Hotter garbage
      nodePackages_latest.nodemon # Hot garbage runtime
      nodePackages_latest.typescript # Typescript language
      nodePackages_latest.typescript-language-server # Typescript LSP
      pyright # Python LSP
      python312Full # Python programming language
      python312Packages.pip # OG Python package manager
      python312Packages.pynvim # Python client for neovim
      stylua # Opinionated lua formatter
      uv # Python package installer
  ];  
}
