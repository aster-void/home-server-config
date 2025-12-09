{pkgs, ...}: {
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    intel-compute-runtime
    vulkan-loader
    vulkan-validation-layers
  ];
  hardware.graphics.extraPackages32 = with pkgs.pkgsi686Linux; [
    vulkan-loader
    vulkan-validation-layers
  ];
}
