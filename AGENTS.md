# CLAUDE.md / AGENTS.md

This file provides guidance all kinds of coding agents when working with code in this repository.

## リポジトリ概要

このリポジトリは、Blueprint を使用した NixOS flake ベースのホームサーバー構成管理システムです。
NixOS システム設定と Home Manager によるユーザー環境設定を統合的に管理します。

主要な依存関係：
- Blueprint: Flake 構造の簡素化
- Home Manager: ユーザー環境管理
- agenix: 秘密情報の暗号化管理
- comin: 自動デプロイメント
- playit-nixos-module: ゲームサーバートンネリング
- nix-minecraft: Minecraft サーバー管理

## ディレクトリ構造

- `hosts/carbon/`: ホスト固有の設定
  - `configuration.nix`: メインのホスト設定（モジュールのインポート）
  - `services/`: サービス設定（Docker, Dokploy, Minecraft, Syncthing等）
  - `system/`: システム設定（ネットワーク、電源、ユーザー、WiFi AP）

- `modules/nixos/`: 再利用可能な NixOS モジュール
  - `common/`: 共通システム設定（base, nix, networking, users, secrets等）
  - `desktop/`: デスクトップ環境設定
  - `workspace/`: 開発用コンテナ設定

- `modules/home/`: Home Manager 設定
  - `profile-dev/`: 開発者プロファイル（Helix, Git, Fish, Starship等のツール設定）

- `secrets/`: agenix による暗号化された秘密情報

## 開発環境

devshell には以下のツールが含まれています：
- `agenix`: 秘密情報の暗号化・復号化
- `minecraftctl`: Minecraft サーバー管理CLI
- `playit-cli`: playit.gg トンネリングCLI
- `lefthook`: Git hooks 管理（自動でインストールされます）
- `bun`: JavaScript/TypeScript ランタイム

# システムの編集について

システムは NixOS で記述されています。
システムのファイルを直接編集するのではなく、このリポジトリのファイルに変更を加えてください。

# コミット・プッシュポリシー

コミットは適切に分割し、自己判断で行ってください。
プッシュはユーザーの許可がない限り絶対にしないでください。

# コマンド

```sh
# ビルド
nh os build . --hostname carbon --no-nom
```
