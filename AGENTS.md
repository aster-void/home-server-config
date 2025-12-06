# CLAUDE.md / AGENTS.md

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

## コミット

形式: `{scope}: {説明}` （例: `hosts/carbon: add dokploy service` `meta: slim down AGENTS.md`）
- scope: `flake` / `hosts/{hostname}` / `modules/{module}` / `secrets` / `treewide` / `meta`

## コマンド

```sh
# Don't pipe it. it will hide exit code.
nh os build . --hostname carbon --no-nom --quiet -- --quiet
```
