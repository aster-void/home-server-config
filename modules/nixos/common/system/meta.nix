{
  lib,
  inputs,
  hostName ? null,
  ...
}: let
  sshAuthorizedKeys =
    builtins.fromJSON (builtins.readFile (inputs.self + "/config/ssh-authorized-keys.json"));
in {
  options.meta = {
    hostname = lib.mkOption {
      type = lib.types.str;
      description = "Host name propagated to modules that need host-specific metadata.";
    };
    sshAuthorizedKeys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "Authorized SSH public keys shared across admin users.";
    };
  };

  config.meta = {
    hostname = lib.mkDefault hostName;
    sshAuthorizedKeys = lib.mkDefault sshAuthorizedKeys;
  };
}
