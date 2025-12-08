{
  config,
  lib,
  ...
}: let
  inherit (config.age) secrets;
in {
  # Cloudflare tunnel user (required for static user instead of DynamicUser)
  users.users.cloudflared = {
    isSystemUser = true;
    group = "cloudflared";
  };
  users.groups.cloudflared = {};

  # Cloudflare tunnel configuration
  age.secrets = {
    cloudflared-carbon = {
      file = ../../../secrets/cloudflared/carbon.json.age;
      owner = "cloudflared";
      group = "cloudflared";
      mode = "0400";
    };
    cloudflared-cert-pem = {
      file = ../../../secrets/cloudflared/cert.pem.age;
      owner = "cloudflared";
      group = "cloudflared";
      mode = "0400";
    };
  };

  # Override DynamicUser to use static cloudflared user for agenix secrets
  systemd.services."cloudflared-tunnel-carbon" = {
    serviceConfig = {
      DynamicUser = lib.mkForce false;
      User = "cloudflared";
      Group = "cloudflared";
    };
  };

  services.cloudflared = {
    enable = true;
    # Note that this is **necessary** for a fully declarative set up, as routes can not otherwise be created outside of the Cloudflare interface.
    # See [Cert.pem](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/tunnel-useful-terms/#certpem) for information about the file, and [Tunnel permissions](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/do-more-with-tunnels/local-management/tunnel-permissions/) for a comparison between the account certificate and the tunnel credentials file.
    certificateFile = secrets.cloudflared-cert-pem.path;

    tunnels = {
      carbon = {
        credentialsFile = secrets.cloudflared-carbon.path;
        default = "http_status:404";
        ingress = {
          "carbon.aster-void.dev" = "ssh://localhost:22";
          "dokploy.aster-void.dev" = "http://127.0.0.1:3000";
          "habit.aster-void.dev" = "http://127.0.0.1:3005";
          "syncthing.aster-void.dev" = {
            service = "http://127.0.0.1:8384";
            originRequest.httpHostHeader = "127.0.0.1";
          };
        };
      };
    };
  };
}
