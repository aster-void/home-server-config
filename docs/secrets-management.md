# Secrets Management with agenix

このドキュメントでは、agenixを使用したシークレット管理の設定と使用方法について説明します。

## 概要

agenixは、age暗号化を使用してNixOSシステムでシークレットを管理するツールです。SSH公開鍵を使用してシークレットを暗号化し、対応する秘密鍵でNixOSシステム上で復号化します。

## ディレクトリ構成

```
secrets/
└── secrets.nix          # agenix CLI設定（受信者公開鍵の定義）
└── *.age                # 暗号化されたシークレットファイル
```

## シークレットの作成と管理

### 1. 公開鍵の取得

#### ユーザー公開鍵
```bash
# ~/.ssh/id_ed25519.pubから取得
cat ~/.ssh/id_ed25519.pub

# またはGitHubから取得
curl https://github.com/aster-void.keys
```

#### ホスト公開鍵
```bash
# リモートホストから取得
ssh-keyscan carbon

# または直接ファイルから取得（ホスト上で）
sudo cat /etc/ssh/ssh_host_ed25519_key.pub
```

### 2. secrets.nixの更新

`secrets/secrets.nix`ファイル内の公開鍵を実際の値に置き換えてください：

```nix
let
  user_aster = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGQGwjkGWrw..."; # 実際の公開鍵
  host_carbon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHmGjkGWrw..."; # 実際のホスト公開鍵
in
{
  "password.age".publicKeys = [ user_aster host_carbon ];
}
```

### 3. シークレットファイルの作成

```bash
# agenixパッケージのインストール（初回のみ）
nix profile install github:ryantm/agenix

# シークレットファイルの作成・編集
agenix -e secrets/password.age

# 特定の秘密鍵を指定する場合
agenix -e secrets/password.age -i ~/.ssh/id_ed25519
```

### 4. 受信者の変更時の再暗号化

```bash
# secrets.nixの更新後、既存のシークレットを再暗号化
agenix --rekey
```

## NixOSでのシークレット使用

### 基本的な使用方法

```nix
# configuration.nix
{
  # シークレットファイルの定義
  age.secrets.password.file = ./secrets/password.age;
  
  # シークレットの使用例
  users.users.aster = {
    isNormalUser = true;
    hashedPasswordFile = config.age.secrets.password.path; # /run/agenix/password
    extraGroups = [ "wheel" ];
  };
}
```

### 高度な設定オプション

```nix
age.secrets.database-password = {
  file = ./secrets/database-password.age;
  owner = "postgres";
  group = "postgres";
  mode = "0400";
};
```

## セキュリティ注意事項

1. **平文をNix storeに保存しない**: `builtins.readFile config.age.secrets.xxx.path`は使用禁止
2. **サービス設定でファイルパスを渡す**: 実行時にサービスがファイルから読み取るように設定
3. **適切な権限設定**: `owner`、`group`、`mode`オプションを適切に設定

## トラブルシューティング

### よくある問題

1. **公開鍵が見つからない**: `secrets.nix`内の公開鍵が正しいことを確認
2. **復号化エラー**: 対応する秘密鍵が利用可能であることを確認
3. **ファイル権限エラー**: NixOSモジュール内で適切な`owner`/`group`を設定

### デバッグコマンド

```bash
# 暗号化されたファイルの受信者を確認
age-keygen -y ~/.ssh/id_ed25519

# シークレットファイルの手動復号化（テスト用）
age -d -i ~/.ssh/id_ed25519 secrets/password.age
```
