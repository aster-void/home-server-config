{
  services.upower.enable = true;
  services = {
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 50;

        #Optional helps save long term battery health
        START_CHARGE_THRESH_BAT0 = 65; # 40 and bellow it starts to charge
        STOP_CHARGE_THRESH_BAT0 = 85; # 80 and above it stops charging

        USB_AUTOSUSPEND = 1; # autosuspend 自体は有効
        USB_BLACKLIST = "1e7d:2dcd 046d:c548"; # ROCCATマウス & Logitech Bolt Receiver を除外

        # Screen brightness limits for battery saving
        INTEL_GPU_MIN_FREQ_ON_BAT = 300;
        INTEL_GPU_MAX_FREQ_ON_BAT = 600;
        INTEL_GPU_BOOST_FREQ_ON_BAT = 600;

        # Reduce screen brightness on battery
        BRIGHTNESS_ON_BAT = 30; # 0-100, lower = more battery savings
      };
    };

    power-profiles-daemon.enable = false;
  };

  powerManagement.powertop.enable = true;
}
