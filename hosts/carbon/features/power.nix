{...}: {
  # Disable conflicting power management service
  services.power-profiles-daemon.enable = false;
  
  # Battery charge limiting to prevent overcharging
  services.tlp = {
    enable = true;
    settings = {
      # Battery charge thresholds (percentage)
      START_CHARGE_THRESH_BAT0 = 75; # Start charging at 75%
      STOP_CHARGE_THRESH_BAT0 = 80;  # Stop charging at 80%
      
      # Alternative for multiple batteries
      START_CHARGE_THRESH_BAT1 = 75;
      STOP_CHARGE_THRESH_BAT1 = 80;
      
      # Power saving settings
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };
  
  # Ensure power management is enabled
  powerManagement.enable = true;
}