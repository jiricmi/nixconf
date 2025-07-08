{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/bundles/desktop.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  boot.initrd.luks.devices."luks-cfbafba6-62bd-47ea-8fef-7631551bc4d4".device =
    "/dev/disk/by-uuid/cfbafba6-62bd-47ea-8fef-7631551bc4d4";

  networking.hostName = "jiricmi-laptop";

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "jiricmi" = import ./home.nix;
    };
  };

  services.logind.lidSwitch = "ignore";

  services.tlp.settings = {
    START_CHARGE_THRESH_BAT0 = 60;
    START_CHARGE_THRESH_BAT1 = 60;

    STOP_CHARGE_THRESH_BAT0 = 80;
    STOP_CHARGE_THRESH_BAT1 = 80;
  };

  environment.systemPackages = with pkgs; [
  ];

  system.stateVersion = "24.05";
}
