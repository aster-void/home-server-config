{inputs, ...}: {
  networking.firewall.allowedTCPPorts = [80 443 3000];
  imports = [inputs.nix-dokploy.nixosModules.default];
  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings.live-restore = false;
  virtualisation.docker.rootless.enable = false;
  services.dokploy.enable = true;
}
