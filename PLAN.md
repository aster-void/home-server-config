## 壁紙共有エンジン PLAN (Home Manager × Syncthing)

### 目的

- **Syncthing** で壁紙フォルダを同期し、各 PC で利用できるようにする。
- 設定は **Home Manager** による宣言的管理。人手が介在しない自動運用を目指す。

### 構成概要

- **Server (Primary)**: 壁紙の正本、導入ノード (introducer)
- **PC 1 / PC 2**: フォルダを受信・追従

```text
            +------------------+
            |  Server (Primary)|
            |  - ~/Picutres/Wallpapers/
            |  - introducer    |
            +---------+--------+
                      |
          ------------+------------
          |                         |
  +-------v------+           +------v-------+
  |    PC 1      |           |     PC 2     |
  | - sync recv  |           | - sync recv  |
  +--------------+           +--------------+
```

### 同期トポロジ

- Server は Syncthing の introducer として、PC 1/2 のデバイス登録とフォルダ共有を一括配布。
- フォルダ `~/Picutres/Wallpapers` を 1:N 共有。

### ディレクトリ設計

- 共有フォルダ: `~/Picutres/Wallpapers/`

### 運用フロー

1. Server に新しい画像を追加（必要なら加工して `processed/` へ出力）
2. Syncthing により PC 1/2 に配布・同期（PC 側は手動で壁紙に利用）

（注）壁紙の自動適用はこの計画の対象外。各 PC で任意の方法で利用する。

#### 宣言対象

- Syncthing フォルダ・デバイス: Home Manager で `services.syncthing` を宣言

### Syncthing 設定のポイント

- Server で `introducer=true`、フォルダ `~/Picutres/Wallpapers` を PC へ共有

### 運用ポリシー（最小）

- 単純に画像を同期するのみ（編集・適用ポリシーは本計画の対象外）

### セキュリティ

- デバイス ID は機微度低だが、Syncthing API Key は agenix で暗号化管理
- ローカルネット優先、外部公開時はリレー/中継の可否を明示

### 導入ステップ（概略）

1. Server で `~/Picutres/Wallpapers` 準備
2. Server の Syncthing でフォルダ共有、introducer 有効化
3. Home Manager モジュールを有効化（Syncthing 設定の宣言）
4. 動作確認（画像追加 → 同期確認）

### メンテナンス指針

- 画像の追加・削除・タグ編集は Server に集約
- バージョン保持期限を定期見直し（容量最適化）
- 新しい DE/WM 追加時は `applyCommand` 判定に分岐を追加
