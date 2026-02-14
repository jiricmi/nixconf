{ pkgs, ... }:
{
  imports = [
    ./../features/base.nix
    ./../features/hyprland
    ./../features/fonts.nix
    ./../features/zsh
    ./../features/stylix
  ];

  stylix.enable = true;

  environment.systemPackages = with pkgs; [
    usbutils
  ];

  services.resolved.enable = true;

  services.openvpn.servers = {
    netioVPN = {
      config = ''
        config /home/jiricmi/nix/vpns/netio.ovpn
                             askpass /home/jiricmi/nix/vpns/.netio-certpass
                             auth-user-pass /home/jiricmi/nix/vpns/.netio-credentials

                             script-security 2
                             up ${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved
                             up-restart
                             down ${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved
                             down-pre
      '';
      autoStart = false;
    };
    jiricmiVPN = {
      config = ''
        config /home/jiricmi/nix/vpns/jiricmi-vpn.ovpn
        askpass /home/jiricmi/nix/vpns/.jiricmi-credentials
                            script-security 2
                            up ${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved
                            up-restart
                            down ${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved
                            down-pre
      '';
      autoStart = false;
    };
  };

  fileSystems."/mnt/netio" = {
    device = "//192.168.101.20/public";
    fsType = "cifs";
    options = [
      "noauto"
      "users"
      "guest"
      "uid=1000"
      "iocharset=utf8"
    ];
  };

  users.users.jiricmi = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "docker"
      "libvirtd"
      "dialout"
      "video"
      "render"
      "fuse"
      "lp"
      "scanner"
      "input"
    ];
  };

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  services.tlp.enable = true;

  programs.fuse.userAllowOther = true;

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  programs.zoxide.enable = true;

  hardware.keyboard.qmk.enable = true;

  environment.variables.EDITOR = "nvim";

}
