{lib, ...}: {
  options.my.profiles = {
    desktop.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable desktop environment (Hyprland + SDDM)";
    };
    gaming.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable gaming profile (Steam, etc.)";
    };
  };
}
