{pkgs, lib, ...}:
{
  imports = [
    ./../features/base.nix
    ./../features/hyprland
    ./../features/stylix
    ./../features/fonts.nix
  ];
}
