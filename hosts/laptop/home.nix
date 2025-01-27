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

  home.packages = with pkgs; [
    signal-desktop
    brave
    kitty
    teams-for-linux
    thunderbird
    obsidian
    keepassxc
    okular
    trezor-suite
    unzip
    zip
    putty
    stm32cubemx
    inputs.nixvim.packages.x86_64-linux.default
    lazygit
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "kitty";
  };

  programs.home-manager.enable = true;
}
