{ pkgs, ... }:
{
  imports = [
    ./../features/base.nix
    ./../features/hyprland
    ./../features/stylix
    ./../features/fonts.nix
    ./../features/zsh
  ];

  environment.systemPackages = [
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
}
