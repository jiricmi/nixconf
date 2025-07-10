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
    fastfetch
    alacritty
    brave
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
    inkscape
    brightnessctl
    qpdf
    distrobox
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "kitty";
  };

}
