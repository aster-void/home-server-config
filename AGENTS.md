# AGENTS.md

This file provides guidance to AI coding agents (including Claude Code) when working with code in this repository.

Note: CLAUDE.md is a symlink to this file (AGENTS.md).

## 概要

NixOS ベースのホームサーバーインフラ構成。Blueprint フレームワークで管理。

**主要コンポーネント:**
- **blueprint**: flake 構造の自動化フレームワーク
- **comin**: Git ベースの継続的デプロイ（push で自動適用）
- **agenix**: シークレット管理（age 暗号化）
- **home-manager**: ユーザー環境管理

## ディレクトリ構造

```
.
├── flake.nix / flake.lock          # Flake エントリーポイント
├── config/                         # 静的設定ファイル
├── hosts/carbon/                   # carbon ホスト固有の設定
│   ├── configuration.nix           # エントリーポイント
│   ├── services/                   # 外向きサービス - このホストで動作するサービス
│   └── system/                     # 内向きサービス - ネットワーク・電源・WiFi 等
├── modules/
│   ├── nixos/                      # 再利用可能なシステムモジュール
│   │   ├── common/                 # 全ホスト共通のベースシステム
│   │   ├── desktop/                # デスクトップ環境
│   │   └── workspace/              # 開発環境コンテナを動かすホスト
│   └── home/                       # 再利用可能なユーザー環境モジュール
│       └── profile-dev/            # development プロファイル
└── secrets/                        # agenix 暗号化された秘密情報
```

## Nix 言語基礎 (重要部分のみ抜粋)

attrset の name が `-` を含んでいても "" は不要。動的な name の場合は、部分的に必要。

```nix
{name}: {
  foo-bar-baz = 1;
  ${name} = 2; # 不要
  "${name}system" = 3; # 必要
}
```

その他演算子

```nix
{a, b, pkgs, baz}: {
  if-a-then-b = a -> b; # false if a && !b. true otherwise.
  containes-foo = pkgs ? foo; # true if attrset `pkgs` contains `foo`, i.e. `pkgs.foo` evaluates.
  foo-bar-or-baz = pkgs.foo.bar or baz; # try to evaluate `pkgs.foo.bar`. if there is a "attribute not found" error in the chain, fall back to baz. (don't use "in case". use only if it depends on the consumer's environment.)
}
```

## ルール

**ファイル配置**:
- 複数ホスト共有 → `modules/nixos/` または `modules/home/`
- carbon 専用 → `hosts/carbon/`
- 2回以上重複 → `modules/nixos/common/` へ抽出
- ユーザーツール → `modules/home/profile-*/programs/`

**modules/ 命名規則**:
- `modules/nixos/` - NixOS システムモジュール（複数ホストで再利用可能）
  - `common/` - 全ホスト共通設定（必須）
  - `common/system/` - システム基盤（users, networking, nix 等）
  - `{feature}/` - 機能別モジュール（desktop, workspace 等）
- `modules/home/` - home-manager モジュール（ユーザー環境）
  - `profile-{name}/` - プロファイル別設定
  - `profile-{name}/programs/` - プログラム固有設定

**hosts/{hostname}/ 構造**:
- `services/` - 外向きサービス（cloudflared, syncthing, minecraft 等）
- `system/` - 内向きサービス（power, wifi-ap 等ホスト固有のシステム設定）

## コミット

形式: `{scope}: {説明}` （例: `hosts/carbon: add dokploy service` `meta: slim down AGENTS.md`）
- scope: `flake` / `hosts/{hostname}` / `modules/{module}` / `secrets` / `treewide` / `meta`

## コマンド

```sh
# Don't pipe it. it will hide exit code.
nh os build . --hostname carbon --no-nom --quiet -- --quiet
# dry run is usually enough:
nh os build . --hostname carbon --dry --no-nom --quiet -- --quiet
```

## Availabel Tools

### Nix Search CLI

Search for nix packages in the https://search.nixos.org index

```sh
# ... like the web interface
nix-search python linter
nix-search --search "python linter"  
# ... by package name
nix-search --name python
nix-search --name 'emacsPackages.*'  
# ... by version
nix-search --version 1.20 
nix-search --version '1.*'
# ... by installed programs
nix-search --program python
nix-search --program "py*"
# ... with ElasticSearch QueryString syntax
nix-search --query-string="package_programs:(crystal OR irb)"
nix-search --query-string='package_description:(MIT Scheme)'
```
