{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./../../modules/bundles/desktop_home.nix
  ];

  home.username = "jiricmi";
  home.homeDirectory = "/home/jiricmi";
  

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    signal-desktop
    brave
    kitty
    teams-for-linux
    
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
