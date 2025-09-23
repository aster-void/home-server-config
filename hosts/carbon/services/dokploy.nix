{inputs, ...}: {
  containers.dokploy = {
    autoStart = true;
    privateNetwork = true;
    forwardPorts = [
      {
        protocol = "tcp";
        hostPort = 3001;
        containerPort = 80;
      }
      {
        protocol = "tcp";
        hostPort = 3002;
        containerPort = 443;
      }
      {
        protocol = "tcp";
        hostPort = 3003;
        containerPort = 3000;
      }
    ];
    config = {
      networking.firewall.allowedTCPPorts = [80 3000];
      imports = [inputs.nix-dokploy.nixosModules.default];
      virtualisation.docker.enable = true;
      virtualisation.docker.daemon.settings.live-restore = false;
      virtualization.docker.rootless.enable = false;
      services.dokploy.enable = true;
      system.stateVersion = "25.11";
    };
  };
}
