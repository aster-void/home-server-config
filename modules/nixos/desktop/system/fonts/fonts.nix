{
  pkgs,
  inputs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  myPkgs = inputs.nix-repository.packages.${system};
in {
  fonts = {
    packages = with pkgs; [
      # primary fonts
      # koruri
      nerd-fonts.meslo-lg
      # Fallback fonts for compatibility
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      myPkgs.sf-mono-nerd-font
    ];

    # MEMO
    # Windows Default -> Yu
    # macOS Default -> Hiragino
    fontconfig = {
      defaultFonts = {
        sansSerif = ["Noto Sans CJK JP"];
        serif = ["Noto Serif CJK JP"];
        # Jetbrains Mono, Noto Sans Mono CJK JP
        monospace = ["MesloLGMNerdFont"];
      };
    };
  };
}
