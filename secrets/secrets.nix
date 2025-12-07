let
  publicKeys = builtins.fromJSON (builtins.readFile ../config/ssh-authorized-keys.json);
in {
  "secrets/playit.toml.age".publicKeys = publicKeys;
  "secrets/cloudflared/carbon.json.age".publicKeys = publicKeys;
  "secrets/cloudflared/cert.pem.age".publicKeys = publicKeys;
  "secrets/syncthing-password.age".publicKeys = publicKeys;
  "secrets/wifi/carbon-wifi.age".publicKeys = publicKeys;
  "secrets/context7-api-key.age".publicKeys = publicKeys;
  "secrets/nix.conf.age".publicKeys = publicKeys;
}
