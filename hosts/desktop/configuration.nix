{ config, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./../../modules/base.nix
      ./../../modules/DE/desktop_env_setup.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "jiricmi-desktop"; 
 
 # Define a user account. Don't forget to set a password with ‘passwd’
  users.users.jiricmi = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "audio" ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "jiricmi" = import ./home.nix;   
    };
  };
 
  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    neovim
    kitty
    brave
    git
  ];

  system.stateVersion = "24.05";
}