# New Host Setup Guide

## Directory Structure

The configuration uses a feature-based approach for better modularity:

```
common/
├── features/
│   ├── base.nix           # Core system (packages, nix, boot, locale)
│   ├── development.nix    # Dev tools, git, comin GitOps
│   ├── networking.nix     # Basic networking, SSH, mDNS
│   ├── users.nix          # Common admin user
│   └── desktop.nix        # Desktop environment (optional)
└── default.nix            # Common imports

hosts/
└── [hostname]/
    ├── configuration.nix           # Host entry point
    ├── default.nix                 # Host feature imports
    ├── hardware-configuration.nix  # Hardware-specific config
    └── features/
        ├── [feature1].nix          # Host-specific features
        └── [feature2].nix          # e.g. gaming, tunneling, etc.
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
    ./hardware-configuration.nix
    ./default.nix

    inputs.comin.nixosModules.comin
    inputs.agenix.nixosModules.default
  ];

  networking.hostName = meta.hostname;
}
```

### hosts/[hostname]/default.nix
```nix
{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Import host-specific features
    ./features/[feature1].nix
    ./features/[feature2].nix
    
    # Import common features that aren't enabled by default
    ../../common/features/desktop.nix  # Optional desktop environment
  ];

  # Host-specific git configuration
  programs.git.config = {
    user.name = "aster@[hostname]";
    user.email = "137767097+aster-void@users.noreply.github.com";
  };
}
```

### hosts/[hostname]/features/[feature].nix
```nix
{
  pkgs,
  config,
  ...
}: {
  # Feature-specific configuration
  # e.g., users, services, firewall rules, packages
}
```

## Common Features

### Always Enabled (common/features/)
- **base.nix**: Core system packages, nix config, boot, locale, keyboard
- **ops.nix**: GitOps operations (git, helix, comin) - required for all hosts
- **networking.nix**: NetworkManager, SSH server, mDNS, basic firewall  
- **users.nix**: Admin user (aster) with SSH keys

### Optional Features (common/features/)
- **desktop.nix**: GNOME desktop environment with Wayland

## Example Host Features

### Carbon Host (gaming server)
- **gaming.nix**: Minecraft servers, playit.gg tunneling, related users/ports
- **tunneling.nix**: Cloudflare tunnel configuration
- **power.nix**: TLP battery management

## Benefits of Feature-Based Structure

- **Modularity**: Easy to mix and match features
- **Reusability**: Common features shared across hosts
- **Clarity**: Each feature has a single responsibility
- **Flexibility**: Override or extend features as needed

## Adding to flake.nix

Add your new host to the nixosConfigurations in flake.nix:

```nix
nixosConfigurations."[hostname]" = mkSystem {
  system = "x86_64-linux";  # or your architecture
  hostname = "[hostname]";
  modules = [
    ./common                            # Common config imported here
    ./hosts/[hostname]/configuration.nix
    agenix.nixosModules.default
    # Add other modules as needed
  ];
};
```

Note: The `./common` module is imported at the flake level in `mkSystem`, not in the host configuration.