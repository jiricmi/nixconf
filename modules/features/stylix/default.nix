{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  stylix.cursor.name = "Bibata-Modern-Ice";
  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.size = 24;

  stylix.targets.qt.enable = true;
  stylix.targets.qt.platform = "qtct";
  stylix.targets.chromium.enable = true;
  stylix.targets.grub.enable = true;
  stylix.targets.grub.useWallpaper = true;
  stylix.image = ./ow.png;
  stylix.targets.plymouth.enable = true;
}
