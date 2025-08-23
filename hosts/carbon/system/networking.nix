{config, ...}: {
  networking.networkmanager.enable = true;

  networking.firewall.allowedTCPPorts = [22 25565]; # SSH + Minecraft

  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      workstation = true;
    };
  };

  age.secrets.cloudflared-cert-pem.file = ../../../secrets/cloudflared-cert.pem.age;

  services.cloudflared = {
    enable = true;
    tunnels = {
      "dde4e79f-c550-42fa-820e-d53bdae1e9eb" = {
        credentialsFile = config.age.secrets.cloudflared-cert-pem.path;
        default = "http_status:404";
        ingress = {
          "ssh.aster-void.dev" = "ssh://localhost:22";
        };
      };
    };
  };
}
