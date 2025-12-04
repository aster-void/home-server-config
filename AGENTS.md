# CLAUDE.md / AGENTS.md

## ディレクトリ構造

```
.
├── flake.nix / flake.lock          # Flake エントリーポイント
├── config/                         # 静的設定ファイル
├── hosts/carbon/                   # carbon ホスト固有の設定
│   ├── configuration.nix           # エントリーポイント
│   ├── services/                   # このホストで動作するサービス
│   └── system/                     # ネットワーク・電源・WiFi 等
├── modules/
│   ├── nixos/                      # 再利用可能なシステムモジュール
│   │   ├── common/                 # 全ホスト共通のベースシステム
│   │   ├── desktop/                # デスクトップ環境
│   │   └── workspace/              # 開発環境コンテナを動かすホスト
│   └── home/                       # 再利用可能なユーザー環境モジュール
│       └── profile-dev/            # プロファイル [development]
└── secrets/                        # agenix 暗号化された秘密情報
```

## ルール

**ファイル配置**:
- 複数ホスト共有 → `modules/nixos/` または `modules/home/`
- carbon 専用 → `hosts/carbon/`
- 2回以上重複 → `modules/nixos/common/` へ抽出
- ユーザーツール → `modules/home/profile-*/programs/`

## コミット

形式: `{scope}: {説明}` （例: `hosts/carbon: add dokploy service` `meta: slim down AGENTS.md`）
- scope: `flake` / `hosts/{hostname}` / `modules/{module}` / `secrets` / `treewide` / `meta`

## コマンド

```sh
set -o pipefail && nh os build . --hostname carbon --no-nom --quiet 2>&1 | tail -n 30
```
