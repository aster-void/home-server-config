# Workspace Access

- Workspace container listens on host ports `2222` (nix shell) and `2223` (FHS shell).
- The container reuses the host network namespace, so those ports are bound directly on the host.
- `2222` drops you into the native nix environment (`fish` login shell).
- `2223` forces the `buildFHSEnv` shell wrapper.
- Both entry points authenticate with the same SSH keys defined in `meta.sshAuthorizedKeys`.

## Inside LAN

- Connect directly with `ssh -p 2222 aster@<host>` for the nix shell.
- Use `ssh -p 2223 aster@<host>` for the FHS shell.

## Over Cloudflare Tunnel

- `workspace.aster-void.dev` targets the nix shell, `fhs.workspace.aster-void.dev` targets the FHS shell. Both Cloudflare ingress rules forward to `localhost` on their respective ports and are served directly by the workspace container.
- Cloudflare Access fronts both hostnames, so the SSH client must be proxied through `cloudflared`.
- For ad-hoc sessions run `cloudflared access ssh --hostname workspace.aster-void.dev --` (or `fhs.workspace.aster-void.dev`) and append your normal SSH arguments.
- For day-to-day use add to `~/.ssh/config`:

```sshconfig
Host workspace.aster-void.dev
  Port 2222

Host fhs.workspace.aster-void.dev
  Port 2223

Host *.aster-void.dev
  ProxyCommand cloudflared access ssh --hostname %h --destination localhost:%p
  User aster
```

- With that config `ssh workspace.aster-void.dev` opens the nix shell and `ssh fhs.workspace.aster-void.dev` opens the FHS shell without websocket handshake errors.
- The FHS shell ships a vendor Fish profile that sets `__fish_prompt_hostname=FHS`, so prompts clearly show when you are inside the FHS environment without runtime markers.
