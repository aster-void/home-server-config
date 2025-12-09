{
  pkgs,
  flake,
  inputs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
in {
  home.packages =
    [
      inputs.zen-browser.packages.${system}.beta
    ]
    ++ [
      # == my tools ==
      flake.packages.${system}.setpaper
    ]
    ++ (with pkgs; [
      # Apps
      thunderbird # email client

      ## Browser
      firefox
      chromium
      brave

      ## Social
      slack
      discord
      vesktop # another discord client
      legcord # yet another discord client
      jitsi # messaging

      ## Images & Videos
      amberol # music player
      kooha # screen recorder
      nomacs # view and crop image better
      gthumb # image cropper
      gimp # image editor
      inkscape # looks like image and video editor
      pinta # easy-to-use image editor

      ## Note taking
      appflowy # notion alternative
      obsidian # note taking app
      # my.lotion-bin # notion

      ## System
      mission-center # resource monitor
      authenticator

      ## Other Apps
      localsend
      arandr # display placer

      # Develop
      ## Code Editor
      zed-editor
      # code-cursor
      windsurf
      drawio

      ## Terminal
      alacritty
      kitty
      ghostty

      # System manager
      blueberry # gui bluetooth manager
      dunst # notification daemon
      ## bluetooth
      bluez
      bluez-tools

      ## media ctl
      pavucontrol
      pulseaudio
      brightnessctl
      asciinema
      solaar # logicool conf

      ## GPU
      # nvtopPackages.full # broken

      # WM
      hyprpicker # color picker
      blobdrop # drag & drop from shell

      ## Screen Shot / record
      hyprshot
      gpu-screen-recorder # screen recorder
      wf-recorder # another screen recorder

      ## Wallpaper
      variety
      hyprpaper

      ## bars
      waybar
      polybar
      cava # used in waybar
      ## Launchers
      nwg-launchers
      fuzzel
      rofi

      # File Viewer
      feh # image viewer that is too simple
      kdePackages.gwenview # file manager that actually works
      nemo # file manager
      vlc # music player
      playerctl
      libreoffice
      timg # cat for images
      dragon-drop

      # gui drivers? idk
      libsForQt5.qt5.qtwayland
      qt6.qtwayland
      qt6Packages.qtstyleplugin-kvantum # SVG based theme engine for Qt/KDE
      gtk3
      gtk4
      xwayland
    ]);
}
