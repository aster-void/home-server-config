{
  pkgs,
  inputs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  hazkey = inputs.nix-hazkey.packages.${system};
  fcitx5-addons = with pkgs; [
    fcitx5-mozc
    fcitx5-mozc-ut
    hazkey.fcitx5-hazkey
  ];
in {
  services.hazkey.enable = true;
  services.hazkey.libllama.package = hazkey.libllama-vulkan;

  home.packages = [
    hazkey.hazkey-settings
  ];

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = fcitx5-addons;
  };
  home.sessionVariables = {
    XMODIFIERS = "@im=fcitx";
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    INPUT_METHOD = "fcitx";
  };
}
