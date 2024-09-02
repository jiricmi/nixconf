{
  pkgs,
  config,
  lib,
  ...
}:
{
  xdg.configFile."lf/icons".source = ./icons;

  programs.lf = {
    enable = true;

    commands = {
      editor-open = ''$$EDITOR "$f"'';
    };

    keybindings = {
      "." = "set hidden!";
      D = "delete";
      p = "paste";
      dd = "cut";
      y = "copy";
      "<enter>" = "open";
      a = "rename";
      gn = "cd ~/nixconf";
    };

    settings = {
    reverse = true;
    preview = true;
    hidden = true;
    icons = true;
    drawbox = true;
    ignorecase = true;
    relativenumber = true;
    promptfmt = "\033[34;1m%d\033[0m\033[1m%f\033[0m";
    };

    extraConfig = let
      previewer = pkgs.writeShellScriptBin "pv.sh" ''
        file=$1
        w=$2
        h=$3
        x=$4
        y=$5

          if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
              ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
              exit 1
          fi
          ${pkgs.pistol}/bin/pistol "$file"
        '';
        cleaner = pkgs.writeShellScriptBin "clean.sh" ''
          ${pkgs.ctpv}/bin/ctpvclear
          ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
        '';
      in ''
        # set cleaner ''${pkgs.ctpv}/bin/ctpvclear
        set cleaner ${cleaner}/bin/clean.sh
        set previewer ${pkgs.ctpv}/bin/ctpv
        cmd stripspace %stripspace "$f"
        setlocal ~/Projects sortby time
        setlocal ~/Projects/* sortby time
        setlocal ~/Downloads/ sortby time
      '';
  };
}

