{ pkgs, inputs, ... }:

let
  guiApps = with pkgs; [
    signal-desktop
    brave
    teams-for-linux
    thunderbird
    keepassxc
    vlc
    inkscape
    dbeaver-bin
    discord
    obsidian
    antigravity
  ];

  cliTools = with pkgs; [
    fastfetch
    alacritty
    lazygit
    putty
    unzip
    zip
    brightnessctl
    qpdf
    dust
    gemini-cli
    claude-code
    nmap
    inetutils
    fd
    ripgrep
    openocd
    arp-scan
    picocom
  ];

  devTools = with pkgs; [
    inputs.nixvim.packages.x86_64-linux.default
    julia
    python314
    mdbook
  ];

in
{
  imports = [
    ./../features/hyprland/settings.nix
    ./../features/waybar
    ./../features/rofi
    ./../features/wlogout
    ./../features/btop.nix
    ./../features/git.nix
    ./../features/tmux.nix
    ./../features/eza.nix
    ./../features/bat.nix
    ./../features/zoxide.nix
    ./../features/lf
  ];

  home.packages = guiApps ++ cliTools ++ devTools;

  programs.wofi.enable = true;

  programs.alacritty.enable = true;

  stylix.targets.alacritty.enable = true;

  programs.ssh = {
    enable = true;
  };

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
  };

}
