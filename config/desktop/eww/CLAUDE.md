# EWW Configuration

## Structure

- `eww.yuck` - Main configuration file that includes all widget definitions
- `eww.scss` - Main stylesheet that imports all component styles
- `power-menu.yuck` - Power menu widget definition
- `power-menu.scss` - Power menu styles

## Usage

```sh
# Open power menu
eww open power-menu

# Close power menu
eww close power-menu

# Reload configuration
eww reload

# Debug configuration
eww debug
```

## Important Notes

### GTK CSS Limitations

EWW uses GTK CSS, which has different properties than standard CSS:

- ❌ `text-align` is not supported
- ❌ `justify-content` is not supported
- ❌ `backdrop-filter` is not supported
- ✅ Use `margin`, `padding`, `color`, `background-color`, `border`, etc.

### Widget Structure

Widgets are defined in `.yuck` files:
- `defwindow` - Window definition with geometry and stacking
- `defwidget` - Widget component definition
- Attributes like `:class`, `:onclick`, `:orientation`, `:spacing`

### Styling

Styles are written in SCSS and compiled by EWW:
- Use standard GTK CSS properties
- Nesting with `&` is supported
- Variables and mixins are supported

## Power Menu

The power menu provides buttons for:
- Shutdown (`systemctl poweroff`)
- Reboot (`systemctl reboot`)
- Logout (`hyprctl dispatch exit`)
- Lock (`hyprlock`)
- Cancel (closes the menu)

### Design Principles

Background must be semi-transparent with gray tone to ensure visibility on both light and dark wallpapers:
- Use gray color (`rgba(128, 128, 128, ...)` or similar) instead of white/black
- Keep transparency low (0.08-0.12) to allow wallpaper to show through
- This ensures the menu is visible on any background while maintaining aesthetic consistency
