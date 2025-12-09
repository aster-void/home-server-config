{hyprshot}:
hyprshot.overrideAttrs (_old: {
  patchPhase = ''
    sed -i 's/\bslurp\b/ slurp -c "#ffffff00" /g' hyprshot
  '';
})
