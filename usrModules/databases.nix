
# Programming languages, language server protocols (LSP)
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
  mongodb-compass # GUI for MongoDB
  mysql-workbench # GUI for MySQL
  pgadmin4-desktopmode # GUI for Postgres DB, no sudo required
  postgresql # Run Postgres DB Locally
  tidy-viewer # TUI pretty printer for csv files
  ];  
}
