{pkgs, ...}: let
  setpaper = pkgs.callPackage ../setpaper {};
  wallCommand = ''setpaper --wall "$path"'';
  lockCommand = ''setpaper --lock "$path"'';
in
  pkgs.writeShellApplication {
    name = "wpick";
    runtimeInputs = [
      pkgs.yazi
      setpaper
    ];

    text = ''
      function _help() {
        echo "
          usage:
            wpick wall # pick your wallpaper
            wpick lock # pick your lock screen
            wpick all # choose both your wallpaper and wall at once
            wpick help # show this help
        "
        exit 0
      }

      if [[ $# -ne 1 ]]; then
        _help
      fi
      case "$1" in
        h|help|-h|--help)
          _help
        ;;
      esac

      case "$1" in
        l|lock|-l|--lock)
          path=$(yazi --chooser-file=/dev/stdout)
          ${lockCommand}
        ;;
        w|wall|-w|--wall)
          path=$(yazi --chooser-file=/dev/stdout)
          ${wallCommand}
        ;;
        a|all|-a|--all)
          path=$(yazi --chooser-file=/dev/stdout)
          ${wallCommand}
          ${lockCommand}
        ;;
        -*)
          echo "wpick: Unknown flag: $1"
          exit 1
        ;;
        *)
          echo "please provide valid option. options: lock, wall, all"
          exit 1
      esac
    '';
  }
