# AGENTS.md

## リポジトリ概要

これは、numtide/blueprint で構築された Nix flake ベースのホームサーバーインフラ用 NixOS 設定リポジトリです。Blueprint が flake 出力を配線し、リポジトリ直下のモジュラー構成ファイルを自動で `nixosConfigurations` や `devShell`、`formatter` に束ねます。

## アーキテクチャ

- **flake.nix**: Blueprint を呼び出して入力・システム一覧を定義するメインエントリーポイント
- **hosts/**: ホスト名で整理されたホスト固有の設定 (`nixosConfigurations`)
- **modules/**: 共有 NixOS モジュール (`flake.nixosModules`)
- **devshell.nix** / **formatter.nix**: Blueprint の `devShell` / `formatter` 出力
- **docs/**: システムドキュメントとセットアップガイド

Blueprint が `hosts/*/configuration.nix` を走査して `nixosConfigurations` を構築します。各ホストファイルは `_module.args.meta` を経由して `sshAuthorizedKeys` などのメタデータを配布します。

## 一般的なコマンド

```bash
# システム設定をビルド
nixos-rebuild build --flake .#carbon

# 設定をテスト（ドライラン）
nixos-rebuild dry-build --flake .#carbon

# 現在のシステムに設定を適用（ターゲットホストで実行する場合）
sudo nixos-rebuild switch --flake .#carbon

# リモートホストにビルドしてデプロイ
nixos-rebuild switch --flake .#carbon --target-host carbon

# flake の入力を更新
nix flake update

# flake の構文と評価をチェック
nix flake check

# flake の出力を表示
nix flake show

# 必要なツールを含む開発シェルに入る
nix develop

# Nix ファイルをフォーマット
nix fmt
```

## 設定構造

各ホスト設定は標準の NixOS モジュールシステムから継承されます。`meta` specialArgs は設定ファイルでアクセス可能なホスト固有のメタデータを提供します。

### ディレクトリ構造

```
hosts/
└── carbon/
    ├── configuration.nix        # Blueprint から呼び出されるホストモジュール
    ├── hardware-configuration.nix
    ├── system/                  # ホスト固有の小さな機能モジュール
    └── services/
        ├── default.nix          # サービスモジュールの集約 (flake.nixosModules.* を含む)
        └── minecraft/           # users/servers/playit など用途別モジュール
modules/
└── nixos/
    ├── common/                  # 共通機能 (base, networking, secrets ...)
    │   └── system/              # 実体モジュール群
    ├── desktop/                 # デスクトップ向け設定
    └── workspace/               # workspace コンテナ/プロンプト/パッケージ定義
devshell.nix                     # `.envrc` なしでも `nix develop` で入れる開発環境
formatter.nix                    # `nix fmt` の定義 (treefmt + alejandra)
```

### サービス管理

サービスは各ホストの `services/` ディレクトリ内で 50 行未満の小さなモジュールに分割されています (例: `minecraft/{users,servers,astronaut,playit}.nix`)。`services/default.nix` がこれらをインポートして関心ごとを整理します。

## コーディング規則

- 各ファイルは必要なだけの行数で良い。読みやすさ・再利用性を優先し、冗長さを避ける。
- ディレクトリは適切に分割する。各ディレクトリ 2~10 ファイルが理想。
- **決して**同じことをするコードを重複させてはいけません。
  - 呼び出しスタックの各層は重複してはいけない。
  - 似たようなことをするコードはこれに該当しない。
- 使わなくなったコードは、 **必ず**消す。
- コードの削除に躊躇は必要ない。すべてのコードは保持するのにコストがかかることを忘れてはいけない。

## ドキュメント規則

- `docs/` にドキュメントを配置する。
- 作業前に関連するドキュメントを探す。
- ドキュメントに残す内容は、何をしたかではなく、システムがどう動くかを残す。
- 作業後は、**必ず**作業によって生じた変化をドキュメントに反映する。これを怠ってはならない。

## 注意事項

- nix flake がファイルを認識するには、git でステージングする必要があります: `git add -A -N`

## 問題解決の原則

- **ドキュメントファースト**: 推測ではなく、まずは公式ドキュメントや設定例を参照する
- **最小限の変更**: 複雑な解決策より、シンプルな変更から試す
- **段階的確認**: 小さな変更を重ねて、問題を特定する
- **既存情報の尊重**: ユーザーが提供した情報を軽視しない
- **検証の重要性**: 実際の動作や設定を確認してから回答する
- **最小コードの原則**: コードは短ければ短いほうがいい。長いコードは悪いコードだ。
