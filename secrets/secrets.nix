# agenix CLI設定 - 受信者（SSH公開鍵）を列挙
# このファイルはNixOS構成にimportしない（CLI専用）
let
  # ユーザーの公開鍵（~/.ssh/id_ed25519.pub または https://github.com/aster-void.keys から取得）
  user_aster = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGQGwjkGWrw..."; # TODO: 実際の公開鍵に置き換える
  
  # ホストの公開鍵（ssh-keyscan carbon または /etc/ssh/ssh_host_ed25519_key.pub から取得）
  host_carbon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHmGjkGWrw..."; # TODO: 実際のホスト公開鍵に置き換える
in
{
  # 暗号化ファイルと対応する受信者を定義
  # 例: パスワードファイル
  "password.age".publicKeys = [ user_aster host_carbon ];
  
  # 他のシークレットファイルもここに追加
  # "database-password.age".publicKeys = [ user_aster host_carbon ];
  # "api-key.age".publicKeys = [ user_aster host_carbon ];
}