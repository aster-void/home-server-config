let
  publicKeys = builtins.fromJSON (builtins.readFile ../config/ssh-authorized-keys.json);
in {
  # 暗号化ファイルと対応する受信者を定義
  # 例: パスワードファイル
  "password.age".publicKeys = publicKeys;

  # 他のシークレットファイルもここに追加
  # "database-password.age".publicKeys = [ user_aster host_carbon ];
  # "api-key.age".publicKeys = [ user_aster host_carbon ];
}
