{
  config,
  lib,
  ...
}: let
  cfg = config.my.profiles.desktop;
in {
  services.xserverdisplayManager.gdm = lib.mkIf cfg.enable {
    enable = true;
  };
}
