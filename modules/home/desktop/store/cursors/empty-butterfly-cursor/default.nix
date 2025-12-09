{
  lib,
  stdenvNoCC,
  unzip,
  ...
}: let
  sources = {
    butter = "Empty-Butterfly-Butter-vr7-Linux";
    cyan = "Empty-Butterfly-Cyan-vr7-Linux";
    green = "Empty-Butterfly-Green-vr7-Linux";
    magenta = "Empty-Butterfly-Magenta-vr7-Linux";
    orange = "Empty-Butterfly-Orange-vr7-Linux";
    purple = "Empty-Butterfly-Purple-vr7-Linux";
    red = "Empty-Butterfly-Red-vr7-Linux";
    white = "Empty-Butterfly-White-vr7-Linux";
    yellow = "Empty-Butterfly-Yellow-vr7-Linux";
  };
in
  lib.attrsets.mapAttrs
  (
    name: full-name:
      stdenvNoCC.mkDerivation {
        name = "Empty-Butterfly-Cursor-${name}";
        src = ./.;
        nativeBuildInputs = [unzip];
        buildPhase = ''
          mkdir -p $out/share/icons
          mkdir tmp
          unzip ./${full-name}.zip -d ./tmp >/dev/null
          ls ./tmp
          mv ./tmp/${full-name}/${lib.strings.removeSuffix "-Linux" full-name} $out/share/icons/empty-butterfly-cursor-${name}
          rm ./tmp -rf
        '';
      }
  )
  sources
