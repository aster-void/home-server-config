{
  config,
  pkgs,
  ...
}: {
  # Basic networking setup
  networking.networkmanager.enable = true;
  networking.hostName = config.meta.hostname;

  # SSH access
  networking.firewall.allowedTCPPorts = [22];

  # Cloudflare WARP VPN setup
  # services.cloudflare-warp.enable = true;
  environment.systemPackages = with pkgs; [
    cloudflared
    cloudflare-cli
    cloudflare-warp
  ];

  # mDNS discovery for local network
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
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
  systemd.services.sshd = {
    restartIfChanged = false;
    reloadIfChanged = true;
  };
}
