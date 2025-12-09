{lib, ...}: {
  options.my = {
    shell = {
      glue = {
        enable = lib.mkEnableOption "glued shell";
        type = lib.mkOption {
          type = lib.types.enum ["glassy"];
        };
      };
      caelestia.enable = lib.mkEnableOption "caelestia shell";
    };

    desktop = {
      gaming.enable = lib.mkEnableOption "gaming extension";
    };

    hyprland = {
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
  };
}
