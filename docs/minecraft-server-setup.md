# Minecraft サーバーセットアップ

このドキュメントは、carbon ホストでの Minecraft サーバーサービスのセットアップについて説明します。

## 概要

carbon ホストは `mc-astronaut-server` を systemd サービスとして実行し、サーバーリポジトリを自動的にクローンして更新し、その後 Minecraft サーバーを起動します。

## サービス設定

サービスは `hosts/carbon/services/minecraft.nix` で設定され、以下を提供します：

- `github:aster-void/mc-astronaut-server` からの自動 git リポジトリクローン/更新
- セキュリティのための専用 minecraft ユーザー
- 再起動機能を持つ Systemd サービス
- Minecraft ポート（25565）のファイアウォール設定

## 作成されたファイル

1. `hosts/carbon/configuration.nix` - メインホスト設定
2. `hosts/carbon/hardware-configuration.nix` - ハードウェア固有設定（テンプレート）
3. `hosts/carbon/services/default.nix` - サービスモジュールインポート
4. `hosts/carbon/services/minecraft.nix` - Minecraft サービス設定

## サービス詳細

- **サービス名**: `minecraft-astronaut`
- **ユーザー**: `minecraft`（システムユーザー、自動作成）
- **グループ**: `minecraft`（自動作成）
- **作業ディレクトリ**: `/var/lib/minecraft`
- **リポジトリ**: `https://github.com/aster-void/mc-astronaut-server.git`
- **Java**: OpenJDK 17、最大ヒープ 2GB、最小ヒープ 1GB
- **ポート**: 25565（ファイアウォールルールで設定）
- **再起動ポリシー**: 10秒遅延で常に再起動
- **セキュリティ**: NoNewPrivileges、PrivateTmp、ProtectSystem=strict、ProtectHome

## デプロイコマンド

```bash
# 設定をビルド
nix build .#nixosConfigurations.carbon.config.system.build.toplevel

# carbon ホストにデプロイ（ターゲットマシンで実行）
sudo nixos-rebuild switch --flake .#carbon

# リモートマシンからデプロイ
nixos-rebuild switch --flake .#carbon --target-host carbon
```

## サービス動作

サービスは起動時に以下の操作を実行します：
1. `/var/lib/minecraft` ディレクトリが存在しない場合は作成
2. リポジトリが存在しない場合はクローン、存在する場合は最新の変更をプル
3. `java -Xmx2G -Xms1G -jar server.jar nogui` で Minecraft サーバーを起動
4. サービスが失敗した場合は自動的に再起動

## 重要な注意事項

- hardware-configuration.nix ファイルは実際のハードウェアに合わせてカスタマイズする必要があります
- SSH は鍵ベース認証のみで設定されています
- サービスは分離のため厳格なセキュリティ制限下で実行されます
- Git と OpenJDK 17 は必要なパッケージとしてシステム全体にインストールされます
