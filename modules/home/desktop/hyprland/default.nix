{
  config,
  lib,
  ...
}: let
  cfg = config.my.hyprland;
in {
  imports = [
    ./binds.nix
    ./windowrules.nix
    ./exec.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hypridle.nix
  ];

  options.my.hyprland = {
    primaryMonitor = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Primary monitor name (e.g., eDP-1, DP-1)";
    };
    scale = lib.mkOption {
      type = lib.types.str;
      default = "1.0";
      description = "Monitor scale factor";
    };
    sensitivity = lib.mkOption {
      type = lib.types.str;
      default = "0";
      description = "Mouse sensitivity";
    };
    touchpadScrollFactor = lib.mkOption {
      type = lib.types.str;
      default = "1.0";
      description = "Touchpad scroll factor";
    };
  };

  config = {
    xdg.portal.config.common.default = "*";

    wayland.windowManager.hyprland = {
      enable = true;
      package = null; # Use NixOS module's package
      systemd = {
        enable = true;
        enableXdgAutostart = true;
      };
      xwayland.enable = true;

      settings = {
        # Monitor configuration
        monitor =
          if cfg.primaryMonitor != ""
          then ["${cfg.primaryMonitor},preferred,0x0,${cfg.scale}" ",preferred,auto,1"]
          else [",preferred,auto,1"];

        misc = {
          vrr = 1;
          disable_hyprland_logo = true;
          force_default_wallpaper = 2;
          focus_on_activate = true;
        };

        input = {
          kb_layout = "us";
          kb_variant = "workman";
          kb_options = "caps:escape";
          repeat_rate = 40;
          repeat_delay = 250;
          follow_mouse = 1;
          mouse_refocus = false;
          inherit (cfg) sensitivity;
          accel_profile = "flat";

          touchpad = {
            natural_scroll = true;
            disable_while_typing = true;
            scroll_factor = cfg.touchpadScrollFactor;
          };
        };

        general = {
          gaps_in = 0;
          gaps_out = 0;
          border_size = 0;
          "col.active_border" = "rgb(303030)";
          "col.inactive_border" = "rgba(303030aa)";
          layout = "dwindle";
          allow_tearing = true;
        };

        xwayland.force_zero_scaling = true;

        decoration = {
          rounding = 0;
          blur = {
            enabled = true;
            size = 8;
            passes = 3;
            ignore_opacity = false;
            new_optimizations = true;
            xray = false;
          };
        };

        animations = {
          enabled = true;
          bezier = ["myBezier, 0.05, 0.9, 0.1, 1.05"];
          animation = [
            "windows, 1, 2, myBezier"
            "windowsOut, 1, 2, default, popin 80%"
            "border, 1, 2, default"
            "borderangle, 1, 2, default"
            "fade, 1, 2, default"
            "workspaces, 1, 1, default"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        gestures = {
          workspace_swipe_distance = 300;
          workspace_swipe_invert = true;
          workspace_swipe_forever = false;
          workspace_swipe_create_new = true;
        };

        cursor.no_hardware_cursors = false;
      };
    };
  };
}
