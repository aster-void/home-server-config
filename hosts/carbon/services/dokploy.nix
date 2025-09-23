# SOURCE:
# https://github.com/el-kurto/nix-dokploy/blob/main/nix-dokploy.nix
{
  inputs,
  pkgs,
  ...
}: let
  cfg = {
    dataDir = "/var/lib/dokploy";
    database.password = "amukds4wi9001583845717ad2";
    traefik.image = "traefik:v3.5.0";
    dokployImage = "dokploy/dokploy:latest";
  };
in {
  networking.firewall.allowedTCPPorts = [80 443 3000];
  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings.live-restore = false;
  virtualisation.docker.rootless.enable = false;

  systemd.tmpfiles.rules = [
    "d ${cfg.dataDir} 0777 root root -"
    "d ${cfg.dataDir}/traefik 0755 root root -"
    "d ${cfg.dataDir}/traefik/dynamic 0755 root root -"
  ];

  systemd.services.dokploy-stack = {
    description = "Dokploy Docker Swarm Stack";
    after = ["docker.service"];
    requires = ["docker.service"];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;

      ExecStart = let
        script = pkgs.writeShellApplication {
          name = "dokploy-stack-start";
          runtimeInputs = [
            pkgs.curl
            pkgs.docker
            pkgs.iproute2
            pkgs.gawk
          ];
          text = ''
            advertise_addr="$(ip -4 route get 1.1.1.1 | awk '{for(i=1;i<=NF;i++) if($i=="src"){print $(i+1); exit}}')"

            # Initialize swarm if not already active
            if ! docker info | grep -q "Swarm: active"; then
              echo "Initializing Docker Swarm with advertise address $advertise_addr..."
              docker swarm init --advertise-addr "$advertise_addr"
            fi

            # Deploy Dokploy stack
            if docker stack ls --format '{{.Name}}' | grep -q '^dokploy$'; then
              echo "Dokploy stack already deployed, updating stack..."
            else
              echo "Deploying Dokploy stack..."
            fi
            ADVERTISE_ADDR="$advertise_addr" \
            POSTGRES_PASSWORD="${cfg.database.password}" \
            DOKPLOY_IMAGE="${cfg.dokployImage}" \
            DATA_DIR="${cfg.dataDir}" \
            docker stack deploy -c ${inputs.nix-dokploy}/dokploy.stack.yml dokploy
          '';
        };
      in "${script}/bin/dokploy-stack-start";

      ExecStop = let
        script = pkgs.writeShellScript "dokploy-stack-stop" ''
          ${pkgs.docker}/bin/docker stack rm dokploy || true
        '';
      in "${script}";
    };

    wantedBy = ["multi-user.target"];
  };

  systemd.services.dokploy-traefik = {
    description = "Dokploy Traefik container";
    after = ["docker.service" "dokploy-stack.service"];
    requires = ["docker.service" "dokploy-stack.service"];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;

      ExecStart = let
        script = pkgs.writeShellApplication {
          name = "dokploy-traefik-start";
          runtimeInputs = [pkgs.docker];
          text = ''
            if docker ps -a --format '{{.Names}}' | grep -q '^dokploy-traefik$'; then
              echo "Starting existing Traefik container..."
              docker start dokploy-traefik
            else
              echo "Creating and starting Traefik container..."
              docker run -d \
                --name dokploy-traefik \
                --network dokploy-network \
                --restart=always \
                -v /var/run/docker.sock:/var/run/docker.sock \
                -v ${cfg.dataDir}/traefik/traefik.yml:/etc/traefik/traefik.yml \
                -v ${cfg.dataDir}/traefik/dynamic:/etc/dokploy/traefik/dynamic \
                -p 80:80/tcp \
                -p 443:443/tcp \
                -p 443:443/udp \
                ${cfg.traefik.image}
            fi
          '';
        };
      in "${script}/bin/dokploy-traefik-start";

      ExecStop = let
        script = pkgs.writeShellScript "dokploy-traefik-stop" ''
          ${pkgs.docker}/bin/docker stop dokploy-traefik || true
        '';
      in "${script}";
      ExecStopPost = let
        script = pkgs.writeShellScript "dokploy-traefik-rm" ''
          ${pkgs.docker}/bin/docker rm dokploy-traefik || true
        '';
      in "${script}";
    };

    wantedBy = ["multi-user.target"];
  };
}
