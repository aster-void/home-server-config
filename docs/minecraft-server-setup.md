# Minecraft Server Setup

This document describes the setup of the Minecraft server service on the carbon host.

## Overview

The carbon host runs the `mc-astronaut-server` as a systemd service that automatically clones and updates the server repository, then starts the Minecraft server.

## Service Configuration

The service is configured in `hosts/carbon/services/minecraft.nix` and provides:

- Automatic git repository cloning/updating from `github:aster-void/mc-astronaut-server`
- Dedicated minecraft user for security
- Systemd service with restart capabilities
- Firewall configuration for Minecraft port (25565)

## Files Created

1. `hosts/carbon/configuration.nix` - Main host configuration
2. `hosts/carbon/hardware-configuration.nix` - Hardware-specific settings (template)
3. `hosts/carbon/services/default.nix` - Service module imports
4. `hosts/carbon/services/minecraft.nix` - Minecraft service configuration

## Service Details

- **Service name**: `minecraft-astronaut`
- **User**: `minecraft` (system user, created automatically)
- **Group**: `minecraft` (created automatically)
- **Working directory**: `/var/lib/minecraft`
- **Repository**: `https://github.com/aster-void/mc-astronaut-server.git`
- **Java**: OpenJDK 17 with 2GB max heap, 1GB min heap
- **Port**: 25565 (configured in firewall rules)
- **Restart policy**: Always restart with 10s delay
- **Security**: NoNewPrivileges, PrivateTmp, ProtectSystem=strict, ProtectHome

## Deployment Commands

```bash
# Build configuration
nix build .#nixosConfigurations.carbon.config.system.build.toplevel

# Deploy to carbon host (run on target machine)
sudo nixos-rebuild switch --flake .#carbon

# Deploy from remote machine
nixos-rebuild switch --flake .#carbon --target-host carbon
```

## Service Behavior

The service performs the following operations on startup:
1. Creates `/var/lib/minecraft` directory if it doesn't exist
2. Clones the repository if not present, or pulls latest changes if it exists
3. Starts the Minecraft server with `java -Xmx2G -Xms1G -jar server.jar nogui`
4. Automatically restarts if the service fails

## Important Notes

- The hardware-configuration.nix file needs to be customized for the actual hardware
- SSH is configured for key-based authentication only
- The service runs with strict security restrictions for isolation
- Git and OpenJDK 17 are installed system-wide as required packages
