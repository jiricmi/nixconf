{pkgs, config, lib, inputs, ...}:
{
  imports = [
    ./../features/hyprland/settings.nix
    ./../features/waybar
  ];

}
