# New Host Setup Guide

## Directory Structure

To add a new host, create the following structure:

```
hosts/
└── [hostname]/
    ├── configuration.nix           # Host entry point
    ├── hardware-configuration.nix  # Hardware-specific config
    ├── services/
    │   ├── default.nix            # Service imports
    │   └── [service].nix          # Host-specific services
    └── system/
        ├── default.nix            # Host-specific system config
        ├── users.nix              # Host-specific users
        ├── networking.nix         # Network configuration
        └── [other].nix            # Other host-specific modules
```

## Template Files

### hosts/[hostname]/configuration.nix
```nix
{
  inputs,
  meta,
  ...
}: {
  imports = [
    ../../common               # Common system configuration
    ./hardware-configuration.nix
    ./services
    ./system

    inputs.comin.nixosModules.comin
    inputs.agenix.nixosModules.default
  ];

  networking.hostName = meta.hostname;
}
```

### hosts/[hostname]/system/default.nix
```nix
{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./users.nix
    ./networking.nix
    # Add other host-specific modules
  ];

  # Host-specific git configuration
  programs.git.config = {
    user.name = "aster@[hostname]";
    user.email = "137767097+aster-void@users.noreply.github.com";
  };

  # Host-specific services (if needed)
  # services.comin = { ... };
}
```

### hosts/[hostname]/services/default.nix
```nix
{...}: {
  imports = [
    # Import host-specific services
  ];
}
```

## What's Included in Common

The `common/` module provides:
- Base system packages (git, helix, btop, etc.)
- Terminal compatibility (kitty.terminfo, enableAllTerminfo)
- Nix configuration (flakes, garbage collection)
- Basic security (sudo, fish shell)
- Keyboard layout (workman variant)
- System state version

## Adding to flake.nix

Add your new host to the nixosConfigurations in flake.nix:

```nix
nixosConfigurations."[hostname]" = mkSystem {
  system = "x86_64-linux";  # or your architecture
  hostname = "[hostname]";
};
```