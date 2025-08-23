let
  publicKeys = builtins.fromJSON (builtins.readFile ../config/ssh-authorized-keys.json);
in {
  "secrets/playit.toml.age".publicKeys = publicKeys;
  "secrets/cloudflared-tunnel-token.age".publicKeys = publicKeys;
}
