# AGENTS.md

This file provides guidance to AI coding agents (including Claude Code) when working with code in this repository.

Note: CLAUDE.md is a symlink to this file (AGENTS.md).

## 概要

NixOS ベースの統合システム構成（サーバー + デスクトップ）。Blueprint フレームワークで管理。

**主要コンポーネント:**
- **NixOS**: Linux ディストリビューション（宣言的システム構成）
- **home-manager**: ユーザー環境管理
- **blueprint**: flake 構造の自動化フレームワーク
- **agenix**: シークレット管理（age 暗号化）
- **nix-repository**: カスタム Nix リポジトリ（inputs から利用可能）

## ディレクトリ構造

```
.
├── flake.nix / flake.lock          # Flake エントリーポイント
├── config/                         # 静的設定ファイル（dotfiles）
│   └── desktop/                    # デスクトップアプリの設定ファイル
├── hosts/
│   ├── carbon/                     # ホームサーバー
│   │   ├── configuration.nix
│   │   ├── services/               # 外向きサービス（cloudflared, minecraft等）
│   │   ├── system/                 # 内向きサービス（power, wifi-ap等）
│   │   └── users/                  # ユーザー固有のhome-manager設定
│   ├── dusk/                       # デスクトップ（開発用）
│   ├── amberwood/                  # デスクトップ（開発用）
│   └── bogster/                    # デスクトップ（開発用）
├── modules/
│   ├── nixos/                      # NixOS システムモジュール
│   │   ├── base/                   # 全ホスト共通のベース設定
│   │   ├── desktop/                # デスクトップ環境（Hyprland, 音声, GPU等）
│   │   └── profile-dev/            # 開発者プロファイル
│   └── home/                       # home-manager モジュール
│       ├── desktop/                # デスクトップユーザー環境（シェル, GUI, hyprland等）
│       └── profile-dev/            # 開発ツール（git, helix, fish等）
├── packages/                       # カスタムパッケージ
├── overlays/                       # nixpkgs オーバーレイ
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
- 特定ホスト専用 → `hosts/{hostname}/`
- 2回以上重複 → `modules/` へ抽出
- ユーザー環境・ツール → `modules/home/`
- デスクトップアプリの静的設定 → `config/desktop/`

**modules/ 構造**:
- `modules/nixos/` - NixOS システムモジュール
  - `base/` - 全ホスト共通設定（必須）
  - `base/system/` - システム基盤（users, networking, nix 等）
  - `desktop/` - デスクトップ環境（WM, ハードウェア, サービス等）
  - `profile-{name}/` - プロファイル別設定
- `modules/home/` - home-manager モジュール
  - `desktop/` - デスクトップユーザー環境（hyprland, シェル, GUI, アプリ等）
  - `profile-{name}/` - プロファイル別設定
  - `profile-{name}/programs/` - プログラム固有設定

**hosts/{hostname}/ 構造**:
- `configuration.nix` - ホストのエントリーポイント
- `hardware-configuration.nix` - ハードウェア固有設定
- `services/` - 外向きサービス（サーバーホストのみ）
- `system/` - ホスト固有のシステム設定
- `users/` - ユーザー固有のhome-manager設定

## コミット

形式: `{scope}: {説明}` （例: `hosts/carbon: add dokploy service` `meta: slim down AGENTS.md`）
- scope: `flake` / `hosts/{hostname}` / `modules/{module}` / `config` / `packages` / `overlays` / `secrets` / `treewide` / `meta`

## コマンド

```sh
# Don't pipe it. it will hide the exit code.
nh os build . --hostname carbon --no-nom --quiet -- --quiet
```

## Available Tools

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

## Tips

- You don't need to specify CWD manually. it's always here, in the root repo. use `.` rather than `/home/:user/path.../home-server-config`
