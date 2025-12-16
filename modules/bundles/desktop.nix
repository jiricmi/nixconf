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

  fileSystems."/mnt/jiricmi-server/confident" = {
    device = "//29.31.10.205/confident";
    fsType = "cifs";
    options = [
      "credentials=/home/jiricmi/nix/vpns/.smb_conf_credentials"
      "uid=1000"
      "gid=100"
      "file_mode=0700"
      "dir_mode=0700"
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=60"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
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

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  programs.zoxide.enable = true;

  hardware.keyboard.qmk.enable = true;

  environment.variables.EDITOR = "nvim";

}
