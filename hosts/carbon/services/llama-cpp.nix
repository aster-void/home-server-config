{
  pkgs,
  lib,
  ...
}: let
  llamaVulkan = pkgs.llama-cpp.override {vulkanSupport = true;};

  # Qwen2.5-Coder-7B-Instruct Q4_K_M (4.68 GB)
  # https://huggingface.co/Qwen/Qwen2.5-Coder-7B-Instruct-GGUF
  model = pkgs.fetchurl {
    url = "https://huggingface.co/Qwen/Qwen2.5-Coder-7B-Instruct-GGUF/resolve/main/qwen2.5-coder-7b-instruct-q4_k_m.gguf";
    hash = "sha256-UJKH94y01M9rOENzRzO5FLLBWOQ+Iqf0v16WOACJTTw=";
  };
in {
  services.llama-cpp = {
    enable = true;
    package = llamaVulkan;
    host = "127.0.0.1";
    port = 11434;
    model = "${model}";
    openFirewall = false;
    extraFlags = [
      "--ctx-size"
      "4096"
      "--threads"
      "12"
      "--batch-size"
      "256"
      "--ubatch-size"
      "32"
      "--n-gpu-layers"
      "22"
      "--flash-attn"
      "on"
      "--cont-batching"
      "--temp"
      "0.15"
      "--top-p"
      "0.9"
      "--top-k"
      "40"
      "--repeat-penalty"
      "1.05"
    ];
  };

  hardware.graphics.enable = true;

  # Run llama-cpp as unprivileged user
  users.users.llama-cpp = {
    isSystemUser = true;
    group = "llama-cpp";
  };
  users.groups.llama-cpp = {};

  systemd.services.llama-cpp = {
    serviceConfig = {
      User = "llama-cpp";
      Group = "llama-cpp";
      # Allow GPU access
      SupplementaryGroups = ["video" "render"];
    };
  };
}
