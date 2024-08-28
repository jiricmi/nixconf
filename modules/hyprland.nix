{ config, pkgs, inputs, ...}
{
  programs.hyprland = {
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    graphics.enable = true;
  };
}
