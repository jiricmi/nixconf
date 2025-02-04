{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./../../modules/bundles/desktop_home.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.username = "jiricmi";
  home.homeDirectory = "/home/jiricmi";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  programs.home-manager.enable = true;
}
