{
  config,
  pkgs,
  lib,
  ...
}:
let
  startupScript = pkgs.writeShellScriptBin "start" ''
    waybar &
  '';

  exec-once = [
    (lib.getExe startupScript)
  ];

in
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
      ];

      monitor = [
        "desc:BOE 0x0791, preferred, auto, 1"
        ", prefered, auto, 1"
      ];

      input = {
        kb_layout = "us,cz";
        kb_variant = ",qwerty";
        kb_model = "";
        kb_options = "grp:alt_shift_toggle";
        kb_rules = "";
        follow_mouse = 1;
        sensitivity = 0;
        numlock_by_default = true;
      };

      misc = {
        force_default_wallpaper = 0;
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" =
          lib.mkForce "rgba(${config.stylix.base16Scheme.base0E}ff) rgba(${config.stylix.base16Scheme.base09}ff) 60deg";
        "col.inactive_border" = lib.mkForce "rgba(${config.stylix.base16Scheme.base00}ff)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 5;
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.25, 0.9, 0.1, 1.02";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      "$mainMod" = "SUPER";
      bind =
        [
          # Custom binds
          "$mainMod, T, exec, kitty"
          "$mainMod, F, exec, rofi -show drun -show-icons"
          "$mainMod, C, exec, julia"
          "$mainMod, Q, killactive"
          "$mainMod, B, exec, brave"
          "$mainMod, M, exit"
          "$mainMod, V, togglefloating"
          ", Print, exec, grim -g \"$(slurp -d)\" - | wl-copy"

          # Move focus window
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (
            builtins.genList (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
                "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            ) 10
          )
        );

      # Mouse change size
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindl = [
        ", switch:off:Lid Switch,exec,hyprctl keyword monitor \"eDP-1, preferred, auto, 1\""
        ", switch:on:Lid Switch,exec,hyprctl keyword monitor \"eDP-1, disable\""
      ];

      exec-once = exec-once;
    };
  };
}
