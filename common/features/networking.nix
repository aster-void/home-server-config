{...}: {
  # Basic networking setup
  networking.networkmanager.enable = true;
  
  # SSH access
  networking.firewall.allowedTCPPorts = [22];
  
  # mDNS discovery for local network
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      workstation = true;
    };
  };

  # SSH server
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "yes";
    };
  };
}