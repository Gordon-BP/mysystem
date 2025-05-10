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
      stylua # Opinionated lua formatter
      uv # Python package installer
      (python312Full.withPackages ( # Python programming language
        ps: with ps; [
          pip # OG Python package manager
          pynvim # Python client for neovim
          llm # CLI for talking to llms
          llm-gguf # Plugin to use llm to talk to self-hosted llms
          llm-openai-plugin # Plugin to use llm to talk to GPT models
          ]
    ))
  ];
}
