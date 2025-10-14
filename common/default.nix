{inputs, ...}: {
  imports = [
    inputs.comin.nixosModules.comin
    inputs.agenix.nixosModules.default

    ./features/secrets.nix
    ./features/base.nix
    ./features/ops.nix
    ./features/networking.nix
    ./features/users.nix
  ];

  system.activationScripts = {
    kill-warp-svc = {
      text = ''
        kilall -r warp-svc
      '';
    };
  };
}
