# playit.gg セットアップガイド

## 概要

playit.gg エージェントをNixOS上で宣言的に常駐させるためのセットアップ手順。`playit-nixos-module`とagenixを使用した機密管理を行います。

## 前提条件

- NixOS（flakes有効化済み）
- agenix設定済み
- x86_64-linux環境

## 設定ファイル

### flake.nix

playit-nixos-moduleの追加:

```nix
inputs = {
  # ... 既存のinputs ...
  playit-nixos-module.url = "github:pedorich-n/playit-nixos-module";
};

outputs = {
  nixpkgs,
  agenix,
  playit-nixos-module,
  ...
} @ inputs: {
  nixosConfigurations."carbon" = mkSystem {
    system = "x86_64-linux";
    hostname = "carbon";
    modules = [
      ./hosts/carbon/configuration.nix
      agenix.nixosModules.default
      playit-nixos-module.nixosModules.default
    ];
  };
};
```

### services/playit.nix

```nix
{config, ...}: {
  # System user for playit service
  users.groups.playit = {};
  users.users.playit = {
    isSystemUser = true;
    group = "playit";
  };

  # Age secret for playit configuration  
  age.secrets.playit-secret.file = ./secrets/playit.toml.age;

  # playit.gg service configuration
  services.playit = {
    enable = true;
    user = "playit";
    group = "playit";
    secretPath = config.age.secrets.playit-secret.path;
  };

  # Alternative (plain text; NOT RECOMMENDED for production):
  # services.playit.secretPath = "./secrets/playit.toml";
}
```

## 初回セットアップ手順

### 1. 一時起動してClaim

```bash
# 開発シェルに入る（playit-cliが利用可能）
nix develop

# または直接実行
nix run github:pedorich-n/playit-nixos-module#playit-cli -- start
```

ブラウザでアカウント連携後、`~/.config/playit_gg/playit.toml`が生成されます。

### 2. 機密ファイルの配置

```bash
# secretsディレクトリを作成
mkdir -p hosts/carbon/secrets

# agenixで暗号化（推奨）
agenix -e hosts/carbon/secrets/playit.toml.age
# エディタで ~/.config/playit_gg/playit.toml の内容をコピー

# Non-interactive暗号化（playit.toml入手済みの場合）
cat /path/to/playit.toml | agenix -e hosts/carbon/secrets/playit.toml.age

# または一時的に平文配置（非推奨）
cp ~/.config/playit_gg/playit.toml hosts/carbon/secrets/playit.toml
```

### 3. 設定反映

```bash
# ファイルをgitに追加（nixがflakeファイルを認識するため必須）
git add -A -N

# 設定適用
sudo nixos-rebuild switch --flake .#carbon
```

## 検証手順

### サービス状態確認
```bash
systemctl status playit.service
```

### ログ確認
```bash
journalctl -u playit.service -f
```

### Webダッシュボード確認
https://playit.gg/account/tunnels でエージェント接続状況を確認

## トンネル設定

ポート/プロトコル設定は **Webダッシュボード** で行います。
- Minecraft: TCP 25565
- SSH: TCP 22
- その他必要なサービス

## トラブルシューティング

### よくある問題

1. **secretPath エラー**
   - 相対パス使用を確認: `./secrets/playit.toml.age`
   - ファイル存在確認

2. **権限エラー**
   - playitユーザー/グループの権限確認
   - secretファイルの読み取り権限確認

3. **接続エラー**
   - DNS/HTTPS到達性確認
   - ファイアウォール設定確認
   - playit.tomlの内容確認

### 重要な注意点

- **絶対パス使用不可**: Nixでは`/etc/nixos/secrets/playit.toml.age`のような絶対パスは参照できません。`./secrets/playit.toml.age`のような相対パスを使用してください。
- **git staging必須**: `git add -A -N`でファイルをステージング後にflake操作を行う必要があります。
- **機密管理**: 本番環境では必ずagenixを使用し、平文での機密ファイル配置は避けてください。

## 関連ファイル

- `hosts/carbon/services/playit.nix` - playitサービス設定
- `hosts/carbon/secrets/playit.toml.age` - 暗号化された設定ファイル
- `flake.nix` - playit-nixos-module追加設定