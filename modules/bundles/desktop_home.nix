{ pkgs, inputs, ... }:

let
  guiApps = with pkgs; [
    signal-desktop
    brave
    teams-for-linux
    thunderbird
    keepassxc
    trezor-suite
    jetbrains.datagrip
    libsForQt5.okular
    vlc
    gimp
    inkscape
  ];

  cliTools = with pkgs; [
    fastfetch
    alacritty
    lazygit
    zoxide
    putty
    unzip
    zip
    brightnessctl
    qpdf
    distrobox
    gemini-cli
  ];

  devTools = with pkgs; [
    inputs.nixvim.packages.x86_64-linux.default
    julia
    mdbook
  ];

in
{
  imports = [
    ./../features/hyprland/settings.nix
    ./../features/waybar
    ./../features/rofi
    ./../features/wlogout
    ./../features/btop.nix
    ./../features/git.nix
    ./../features/lf
  ];
  stylix.enable = true;

  # Spojení všech seznamů do jednoho
  home.packages = guiApps ++ cliTools ++ devTools;

  programs.wofi.enable = true;

  programs.ssh = {
    enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
  };

}
