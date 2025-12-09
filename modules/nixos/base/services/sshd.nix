{...}: {
  # SSH access
  networking.firewall.allowedTCPPorts = [22];

  # SSH server
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };
}
