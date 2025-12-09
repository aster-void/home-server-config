{lib, ...}: {
  imports = [
    ./glue
    ./caelestia
  ];

  options.my.shell = {
    glue = {
      enable = lib.mkEnableOption "glued shell";
      type = lib.mkOption {
        type = lib.types.enum [
          "glassy"
        ];
      };
    };
    caelestia.enable = lib.mkEnableOption "caelestia shell";
  };
}
