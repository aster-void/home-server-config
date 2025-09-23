{config, ...}: let
  inherit (config.age) secrets;
in {
  # Cloudflare tunnel configuration
  age.secrets = {
    cloudflared-carbon.file = ../../../secrets/cloudflared/carbon.json.age;
    cloudflared-cert-pem.file = ../../../secrets/cloudflared/cert.pem.age;
  };

  services.cloudflared = {
    enable = true;
    # Note that this is **necessary** for a fully declarative set up, as routes can not otherwise be created outside of the Cloudflare interface.
    # See [Cert.pem](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/tunnel-useful-terms/#certpem) for information about the file, and [Tunnel permissions](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/do-more-with-tunnels/local-management/tunnel-permissions/) for a comparison between the account certificate and the tunnel credentials file.
    certificateFile = secrets.cloudflared-cert-pem.path;

    tunnels = {
      "carbon" = {
        credentialsFile = secrets.cloudflared-carbon.path;
        default = "http_status:404";
        ingress = {
          "carbon.aster-void.dev" = "ssh://localhost:22";

          # aster-void.dev
          "aster-void.dev" = "http://localhost:3004";
          "www.aster-void.dev" = "http://localhost:3004";

          # habit-relay
          "habit.aster-void.dev" = "http://localhost:80";
        };
      };
    };
  };
}
