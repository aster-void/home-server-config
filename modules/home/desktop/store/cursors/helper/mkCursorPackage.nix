{stdenv}: name: src:
stdenv.mkDerivation {
  inherit name src;
  pname = name;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/icons/${name}
    cp -R . $out/share/icons/${name}/
    runHook postInstall
  '';
}
