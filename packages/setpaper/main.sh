function _help() {
  echo "
  setpaper: a small wrapper of hyprpaper to set the paper and reload.

  Usage:
  * in hyprpaper.conf, set \`path\` to ~/.config/wallpaper (or \$XDG_CONFIG_HOME/wallpaper if you have custom XDG_CONFIG_HOME)
  * (optional) in hyprlock.conf, set \`background.path\` to ~/.config/lock

  Flags:
    -h|--help : show this help

    -w|--wall : write to wallpaper
    -l|--lock : write to lock screen background

  Example:
    setpaper -w ./wallpaper.jpg # sets wallpaper to wallpaper.jpg
    setpaper -w -l ./wallpaper.png # sets wallpaper to both wallpaper and lock screen
    setpaper ./wallpaper.jpeg # temporarily changes the wallpaper, which resets after restart
"
  exit 0
}

function error() {
  echo "$1
" >&2
  exit 1
}

# predefine functions
function _load_wall() {
  hyprctl hyprpaper unload "$1"
  hyprctl hyprpaper preload "$1"
  hyprctl hyprpaper wallpaper ",$1"
}

save_wall="false"
save_lock="false"
path=""

# parse args
while [[ $# -gt 0 ]]; do
  case $1 in
    -w|--wall)
      save_wall="true" ;;
    -l|--lock)
      save_lock="true" ;;
    -h|--help)
      _help ;;
    -*)
      error "Unknown option: $1";;
    *)
      path="$1" ;;
  esac
  shift
done

if [ "$path" == "" ]; then
  error "Path not provided"
elif [ ! -f "$path" ]; then
  error "File not found at $path".
fi

# operate
abs_path="$(realpath "$path")"
CONFIG_DIR="${XDG_CONFIG_HOME:-"~/.config"}"
if "$save_wall"; then
  ln -sf "$abs_path" "$CONFIG_DIR/wallpaper"
  _load_wall "$CONFIG_DIR/wallpaper"
fi
if "$save_lock"; then
  # WORKAROUND: hyprlock doesn't recognize soft links yet.
  ln -f "$abs_path" "$CONFIG_DIR/lock"
fi

if [[ "$save_wall" == false && "$save_lock" == false ]]; then
  _load_wall "$abs_path"
fi
