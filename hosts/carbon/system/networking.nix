{config, ...}: {
  networking.networkmanager.enable = true;

  networking.firewall.allowedTCPPorts = [22 25565]; # SSH + Minecraft

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

  age.secrets.cloudflared-tunnel-token.file = ../../../secrets/cloudflared-tunnel-token.age;

  services.cloudflared = {
    enable = true;
    tunnels = {
      "dde4e79f-c550-42fa-820e-d53bdae1e9eb" = {
        credentialsFile = config.age.secrets.cloudflared-tunnel-token.path;
        default = "http_status:404";
        ingress = {
          "carbon.aster-void.dev" = "ssh://localhost:22";
          "mc.aster-void.dev" = "tcp://localhost:25565";
        };
      };
    };
  };
}
