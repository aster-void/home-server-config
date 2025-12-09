{
  git,
  gnumake,
  inkscape,
  xorg,
  stdenvNoCC,
  fetchFromGitHub,
  ...
}:
stdenvNoCC.mkDerivation {
  name = "material-cursor";
  nativeBuildInputs = [git gnumake inkscape xorg.xcursorgen];
  src = fetchFromGitHub {
    owner = "varlesh";
    repo = "material-cursors";
    rev = "2a5f302fefe04678c421473bed636b4d87774b4a";
    hash = "sha256-uC2qx3jF4d2tGLPnXEpogm0vyC053MvDVVdVXX8AZ60=";
  };
  buildPhase = ''
    # HACK: this package doesn't seem to build without the flag
    DBUS_SESSION_BUS_ADDRESS="" make build
  '';
  installPhase = ''
    sed 's|$(DESTDIR)$(PREFIX)'"|$out|" -i ./Makefile
    make install
  '';
}
