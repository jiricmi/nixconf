{pkgs, config, lib, inputs, ...}:
{
  imports = [
    ./../features/hyprland/settings.nix
    ./../features/waybar
    ./../features/rofi
    ./../features/wlogout
    ./../features/btop.nix
<<<<<<< Updated upstream
    ./../features/git.nix
    inputs.nixvim.homeManagerModules.nixvim
    ./../features/nixvim 
   ];
=======
    ./../features/lf
    ./../features/neovim
  ];
>>>>>>> Stashed changes

  stylix.enable = true;

}
