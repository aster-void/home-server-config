{pkgs, ...}: {
  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
    vulkan-loader
    vulkan-validation-layers
  ];
  hardware.graphics.extraPackages32 = with pkgs.pkgsi686Linux; [
    vulkan-loader
    vulkan-validation-layers
  ];
}
