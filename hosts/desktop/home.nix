{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  imports = [
    ./../../modules/bundles/desktop_home.nix
  ];

  home.username = "jiricmi";
  home.homeDirectory = "/home/jiricmi";
  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "24.05"; # Please read the comment before changing.

  programs.home-manager.enable = true;
}
