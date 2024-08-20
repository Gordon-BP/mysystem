
{config, pkgs, inputs, ...} : 
let

in
{
  environment.systemPackages = with pkgs; [
  aria # multithread downloader
  bat # cat with syntax highlighting
  chafa # Terminal graphics
  cmatrix # Enter the matrix
  ctpv # Image previewer for lf
  fd # OSS Find
  fzf # cli fuzzy match
  glow # Render markdown in the terminal
  jq # cli JSON
  lazygit # git but with a tui
  lf # terminal-based file explorer
  llm # Talk to LLMs in the terminal
  mdcat # cat with markdown
  pandoc # document converter
  procs # process info
  ripgrep # Text search util
  sd # find and replace text
  tealdeer # nicer manual pages
  tokei # code stats
  trash-cli # manage recycle bin
  tree # Util to list dir contents
  tree-sitter # Parsing util
  viu # images in the terminal
  # zoxide # cd with memory, but slows zsh startup
  ];
}
