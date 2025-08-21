# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a NixOS configuration repository for home server infrastructure using Nix flakes. The repository manages system configurations for server hosts using a modular, declarative approach.

## Architecture

- **flake.nix**: Main entry point defining system configurations and dependencies
- **hosts/**: Host-specific configurations organized by hostname
- **docs/**: System documentation and setup guides

The flake defines a `nixosConfigurations` attribute set where each host configuration points to its respective configuration file in the `hosts/` directory.

### Current Systems

#### carbon
Home server configuration with the following services:
- Minecraft server (`minecraft-astronaut`) - Automatically managed server from GitHub repository
- SSH server with key-based authentication only
- Firewall configured for Minecraft (port 25565) and SSH (port 22)

## Common Commands

```bash
# Build the system configuration
nix build .#nixosConfigurations.carbon.config.system.build.toplevel

# Test configuration (dry run)
nixos-rebuild dry-build --flake .#carbon

# Apply configuration to current system (if running on target host)
sudo nixos-rebuild switch --flake .#carbon

# Build and deploy to remote host
nixos-rebuild switch --flake .#carbon --target-host carbon

# Update flake inputs
nix flake update

# Check flake syntax and evaluation
nix flake check

# Show flake outputs
nix flake show

# Enter development shell with required tools
nix develop

# Format Nix files
nix fmt
```

## Configuration Structure

Each host configuration inherits from the standard NixOS module system. The `meta` specialArgs provides host-specific metadata accessible in configuration files.

### Directory Structure
```
hosts/
├── carbon/
│   ├── configuration.nix      # Main host configuration
│   ├── hardware-configuration.nix  # Hardware-specific settings
│   └── services/
│       ├── default.nix        # Service module imports
│       └── minecraft.nix      # Minecraft service configuration
```

### Service Management
Services are organized in modular files within each host's `services/` directory. Each service module is imported through the `services/default.nix` file to maintain clean separation of concerns.

## Coding Rules

- 各ファイルは可能な限り小さく保つこと。 20~50行が理想。 **決して100行は超えないようにする**。
- ディレクトリは適切に分割する。各ディレクトリ 2~10 ファイルが理想。

## Documentation Rules

- `docs/` にドキュメントを配置する。
- 作業前に関連するドキュメントを探す。
- ドキュメントに残す内容は、何をしたかではなく、システムがどう動くかを残す。
- 作業後は、**必ず**作業によって生じた変化をドキュメントに反映する。これを怠ってはならない。

## Caveats
- Files must be staged in git for nix flake to see them: `git add -A -N`
