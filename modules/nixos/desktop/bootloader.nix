{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.my.boot;
in {
  options.my.boot = {
    grubDevice = lib.mkOption {
      type = lib.types.str;
      default = "nodev";
    };
    enableLanzaboote = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkMerge [
    {
      environment.systemPackages = [pkgs.sbctl];
    }
    (lib.mkIf cfg.enableLanzaboote {
      # enable secure boot with lanzaboote
      boot.lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };
      # Disable systemd-boot when using lanzaboote
      boot.loader.systemd-boot.enable = lib.mkForce false;
    })
    (lib.mkIf (!cfg.enableLanzaboote) {
      # grub bootloader (when not using lanzaboote)
      boot.loader = {
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot";
        };
        grub = {
          enable = true;
          efiSupport = true;
          useOSProber = true;
          device = cfg.grubDevice;
          default = "saved";
        };
        timeout = 10;
        # Disable systemd-boot when using grub
        systemd-boot.enable = lib.mkForce false;
      };
    })
  ];
}
