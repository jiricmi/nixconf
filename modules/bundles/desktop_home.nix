{ pkgs, inputs, ... }:
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

  home.packages = with pkgs; [
    signal-desktop
    brave
    kitty
    teams-for-linux
    thunderbird
    keepassxc
    trezor-suite
    unzip
    zip
    putty
    inputs.nixvim.packages.x86_64-linux.default
    lazygit
    julia
    zoxide
    jetbrains.datagrip
    libsForQt5.okular
    vlc
    gimp
    freecad
    inkscape
    brightnessctl
    qpdf
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "kitty";
  };

}
