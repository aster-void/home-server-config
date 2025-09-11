{config, ...}: {
  # Cloudflare tunnel configuration
  age.secrets.cloudflared-carbon.file = ../../../secrets/cloudflared/carbon.json.age;

  services.cloudflared = {
    enable = true;
    tunnels = {
      "carbon" = {
        credentialsFile = config.age.secrets.cloudflared-carbon.path;
        default = "http_status:404";
        ingress = {
          "carbon.aster-void.dev" = "ssh://localhost:22";
          "mc.aster-void.dev" = "tcp://localhost:25565";
        };
      };
    };
  };
}
