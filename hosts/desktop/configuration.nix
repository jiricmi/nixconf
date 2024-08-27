{ config, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./../../modules/base.nix
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
 
  # Hyprland
  programs.hyprland = {
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

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    neovim
    kitty
    brave
    git
  ];

  system.stateVersion = "24.05";
}
