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

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "kitty";
  };

  programs.home-manager.enable = true;
}
