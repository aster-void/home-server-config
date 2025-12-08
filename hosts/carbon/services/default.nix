{...}: {
  imports = [
    ./cloudflared.nix
    ./docker.nix
    ./dokploy.nix
    ./llama-cpp.nix
    ./minecraft.nix
    ./syncthing.nix
  ];
}
