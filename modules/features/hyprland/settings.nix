{ config, pkgs, lib, ... }:
let
  startupScript = pkgs.writeShellScriptBin "start" ''
    waybar &
  '';

  exec-once = [
    (lib.getExe startupScript)
  ];

in {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
      ];


      input = {
        kb_layout = "us";
	kb_variant = "";
	kb_model = "";
	kb_options = "";
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
        "col.active_border" = lib.mkForce "rgba(${config.stylix.base16Scheme.base0E}ff) rgba(${config.stylix.base16Scheme.base09}ff) 60deg";
        "col.inactive_border" = lib.mkForce "rgba(${config.stylix.base16Scheme.base00}ff)";
        layout = "dwindle";
      };


      decoration = {
          rounding = 5;
          drop_shadow = true;
          shadow_range = 30;
          shadow_render_power = 3;
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
      bind = [
        # Custom binds
	"$mainMod, T, exec, kitty"
        "$mainMod, F, exec, rofi -show drun -show-icons"
	"$mainMod, Q, killactive"
        "$mainMod, B, exec, brave"
	"$mainMod, M, exit"
	"$mainMod, V, togglefloating"

	# Move focus window
	"$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
      ] ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
              "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );


      # Mouse change size
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

     exec-once = exec-once;
    };
  };
}
