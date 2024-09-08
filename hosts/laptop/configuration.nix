{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules/bundles/desktop.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-cfbafba6-62bd-47ea-8fef-7631551bc4d4".device = "/dev/disk/by-uuid/cfbafba6-62bd-47ea-8fef-7631551bc4d4";
  networking.hostName = "jiricmi-laptop";

  # Define a user account. Don't forget to set a password with ‘passwd’
  users.users.jiricmi = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "audio" "docker"];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "jiricmi" = import ./home.nix;
    };
  };
  networking.hosts = {
    "172.18.1.13" = ["gitlab.int.netio.eu"];
    "172.18.1.14" = ["hades.int.netio.eu"];
    "172.18.1.16" = ["odoo.int.netio.eu"];
  };
  services.logind.lidSwitch = "ignore";

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  environment.variables.EDITOR = "nvim";

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
  ];

  system.stateVersion = "24.05";
}
