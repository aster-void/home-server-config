# Minecraft サーバーセットアップ

## システム構成

- **flake.nix**: nix-mc ライブラリと関連リポジトリの定義
- **hosts/carbon/services/minecraft.nix**: Minecraft サーバー設定

## 関連リンク・ライブラリ

### [Infinidoge/nix-minecraft](https://github.com/Infinidoge/nix-minecraft)
Nix での Minecraft サーバー管理ライブラリ。Fabric、Quilt サーバーをサポート。

**基本的な使用方法:**
```nix
# flake.nix
inputs = {
  nix-minecraft.url = "github:Infinidoge/nix-minecraft";
};

# configuration.nix
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];
  
  services.minecraft-servers = {
    enable = true;
    eula = true;
    servers.my-server = {
      enable = true;
      package = pkgs.fabricServers.fabric-1_18_2; # Fabric サーバー例
    };
  };
}
```

### [aster-void/nix-mc](https://github.com/aster-void/nix-mc)
Forge、NeoForge、Bedrock サーバーをサポートする Minecraft サーバー用 Nix 設定ライブラリ。セキュリティ強化と柔軟なファイル管理を提供。

**主な機能:**
- Forge、NeoForge、Bedrock サーバーのサポート
- セキュリティ強化
- 複数サーバーインスタンス対応
- 柔軟なファイル管理（symlinks、コピー）

**使用方法:**
```nix
# flake.nix
inputs = {
  nix-mc.url = "github:aster-void/nix-mc";
  # バージョン固定されたサーバーソース
  forge-server.url = "github:YourUsername/forge-server-configs/1.20.1";
  forge-server.flake = false;
}

# configuration.nix
services.minecraft = {
  enable = true;
  openFirewall = true;
  
  servers.myserver = {
    type = "forge";
    upstreamDir = forge-server; # バージョン固定ソース
    symlinks = {
      mods = "${forge-server}/mods";
      config = "${forge-server}/config";
    };
    serverProperties = {
      "server-port" = 25565;
      difficulty = "normal";
      "max-players" = 20;
    };
  };
}
```

**設定オプション:**
- `type`: "forge", "neoforge", "bedrock" から選択
- `upstreamDir`: 読み取り専用サーバーファイルの指定
- `symlinks`: MODs、設定ファイルのシンボリックリンク作成
- `serverProperties`: サーバー設定
- `ports`: カスタムポート指定（デフォルト: Java TCP 25565, Bedrock UDP 19132）
