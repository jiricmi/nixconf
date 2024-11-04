{ config, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./../../modules/bundles/desktop.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "jiricmi-desktop"; 
 
 # Define a user account. Don't forget to set a password with ‘passwd’
  users.users.jiricmi = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "audio" "docker" "dialout"];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "jiricmi" = import ./home.nix;   
    };
  };

  environment.variables.EDITOR = "nvim";
 
  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [];

  system.stateVersion = "24.05";
}
