{
  pkgs,
  lib,
  fetchFromGitHub,
  callPackage,
  catppuccin-cursors,
  ...
}: let
  mkCursor = pkgs.callPackage ./helper/mkCursorPackage.nix {};

  # --- collections of multiple cursors

  # supports X cursor and hyprcursor
  catppuccins =
    lib.attrsets.mapAttrs'
    (name: value: {
      name = "catppuccin-cursor-${name}";
      inherit value;
    })
    catppuccin-cursors;

  # only supports X cursor
  empty-butterfly-cursors =
    lib.attrsets.mapAttrs'
    (name: value: {
      name = "empty-butterfly-cursor-${name}";
      inherit value;
    })
    (import ./empty-butterfly-cursor pkgs);

  # --- single cursors ---

  # seems to only support X cursor
  material-cursor = callPackage ./material-cursor.nix {};

  # Hyprcursor only, not currently working
  rose-pine = mkCursor "rose-pine" (fetchFromGitHub {
    owner = "ndom91";
    repo = "rose-pine-hyprcursor";
    rev = "v0.3.2";
    hash = "sha256-ArUX5qlqAXUqcRqHz4QxXy3KgkfasTPA/Qwf6D2kV0U=";
  });

  # Hyprcursor only
  googledot-violet = pkgs.callPackage ./GoogleDot-Violet;
in
  catppuccins
  // empty-butterfly-cursors
  // {
    inherit
      material-cursor
      rose-pine
      googledot-violet
      ;
  }
