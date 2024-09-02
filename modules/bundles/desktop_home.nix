{pkgs, config, lib, inputs, ...}:
{
  imports = [
    ./../features/hyprland/settings.nix
    ./../features/waybar
    ./../features/rofi
    ./../features/wlogout
    ./../features/btop.nix
    ./../features/git.nix
    inputs.nixvim.homeManagerModules.nixvim
    ./../features/nixvim 
   ];

  stylix.enable = true;

}
