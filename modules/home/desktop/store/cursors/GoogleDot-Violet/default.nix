{
  stdenvNoCC,
  unzip,
  ...
}:
stdenvNoCC.mkDerivation {
  name = "GoogleDot-Violet";
  src = ./.;
  nativeBuildInputs = [unzip];
  buildPhase = ''
    mkdir /build/tmp -p
    cd /build/tmp
    cp ${./extracted_GoogleDot-Violet-SVG.zip} src.zip
    unzip src.zip
    rm src.zip
  '';
  installPhase = ''
    cd /build/tmp
    mkdir -p $out/share/icons
    mv * $out/share/icons/
    cd /
    rm build/tmp -r
  '';
}
