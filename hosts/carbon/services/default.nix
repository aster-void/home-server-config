{flake, ...}: {
  imports = [
    ./cloudflared.nix
    ./docker.nix
    ./dokploy.nix
    ./minecraft.nix
    ./syncthing.nix

    # workspace: 開発用コンテナを提供する外向きサービス (SSH port 2222/2223)
    flake.nixosModules.workspace
  ];
}
