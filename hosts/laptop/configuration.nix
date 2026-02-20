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

  boot.initrd.luks.devices."luks-5e1f91b2-e5c5-4e5a-84ed-800972e5073a".device =
    "/dev/disk/by-uuid/5e1f91b2-e5c5-4e5a-84ed-800972e5073a";

  boot.initrd.luks.devices."luks-cfbafba6-62bd-47ea-8fef-7631551bc4d4".device =
    "/dev/disk/by-uuid/cfbafba6-62bd-47ea-8fef-7631551bc4d4";

  networking.hostName = "jiricmi-laptop";

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "jiricmi" = import ./home.nix;
    };
  };

  services.logind.settings.Login.HandleLidSwitch = "ignore";

  services.tlp.settings = {
    START_CHARGE_THRESH_BAT0 = 60;

    STOP_CHARGE_THRESH_BAT0 = 80;
  };

  services.trezord.enable = true;

  environment.systemPackages = with pkgs; [
  ];

  system.stateVersion = "24.05";
}
