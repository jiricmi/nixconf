{pkgs, config, lib, inputs, ...}:
{
  imports = [
    ./../features/hyprland/settings.nix
    ./../features/waybar
    ./../features/rofi
    ./../features/wlogout
    ./../features/btop.nix
  ];

  stylix.enable = true;

}
