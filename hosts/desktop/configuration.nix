{
  config,
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
  boot.extraModulePackages = [ config.boot.kernelPackages.rtl88xxau-aircrack ];
  boot.initrd.luks.devices."luks-20da37b8-0997-4081-b814-19a338b2b0c8".device =
    "/dev/disk/by-uuid/20da37b8-0997-4081-b814-19a338b2b0c8";

  networking.hostName = "jiricmi-desktop";

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "jiricmi" = import ./home.nix;
    };
  };

  # Gaming
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  # ROCm
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [ mangohud ];

  system.stateVersion = "24.05";
}
