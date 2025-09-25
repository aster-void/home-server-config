{
  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings.live-restore = false;
  virtualisation.docker.rootless.enable = false;

  virtualisation.docker.daemon.settings = {
    ipv6 = true;
    # must start with "fd"
    fixed-cidr-v6 = "fd8e::5f6a::1029::/48";
  };
}
