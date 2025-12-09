{
  config,
  lib,
  ...
}: let
  cfg = config.my.profiles.desktop;
in {
  services.displayManager = lib.mkIf cfg.enable {
    ly.enable = true;
    autoLogin.enable = false; # LY doesn't support auto login
  };
}
