# Waybar ガイド

## 🚨 絶対に使用禁止のCSS プロパティ

**これらはエラーを起こします：**

- `@keyframes` - キーフレームアニメーションは未対応
- `transform` - scale(), translateY(), rotate() 等
- `backdrop-filter` - ブラー効果未対応
- `position` - absolute, relative 未対応
- `overflow` - hidden, scroll 等
- `height`, `max-height`, `min-height` - 高さ制約
- `line-height` - 高さ制御未対応
- `white-space`, `text-overflow` - テキスト制御
- `-webkit-*` - プレフィックス未対応
- `!important` - 未対応

## ✅ Waybar対応の代替手法

### 高さ制御
- **`margin`** - 見た目の高さ調整 (`margin: 12px 8px`)
- **`padding`** - 内部スペース (`padding: 0px 8px`)
- **`font-size`** - 要素の高さに影響
- **`min-width`** - 幅のみ制御可能

### テキスト制御
- **config.jsonc** で `max-length: 50` を設定
- CSSでのテキスト制御は不可

### 安全なアニメーション
- **`opacity`** - 透明度変化
- **`box-shadow`** - 影・グロー効果
- **`background`** - 色・グラデーション
- **`border`** - 境界線変化

## 🔧 よくある問題と解決法

### 間違った書き方
```css
#element {
  max-height: 16px;      /* エラー！ */
  overflow: hidden;      /* エラー！ */
  transform: scale(1.1); /* エラー！ */
}
```

### 正しい書き方
```css
#element {
  margin: 8px;           /* 高さ調整 */
  padding: 4px 8px;      /* 内部スペース */
  box-shadow: 0 0 10px;  /* 視覚効果 */
}
```

## 📋 重要なルール

2. **グループ要素にmarginは効かない** - config.jsonc の `spacing` を使用
3. **アニメーションはレイアウトを変更しない** - 視覚効果のみ
4. **段階的に実装してテスト** - 各変更後に動作確認

## 設定ファイル

- **メイン設定**: `config.jsonc`
- **スタイル**: `style.css`
- **カラーパレット**: `macchiato.css` (Catppuccin)

## デバッグのコツ

- エラーログを注意深く確認
- 派手な色でセレクタの動作確認
- config.jsonc と CSS の使い分けを理解
- テスト用コードは完了後に削除

## コーディングルール

- コードは絶対に短く保つ

## システム情報

- waybar は systemd user service で管理されている。
- ファイル変更は自動で再読み込みされるため、明示的にリロードする必要なし。

```sh
# waybar のログを確認する
journalctl --user -u waybar --since '1 minute ago' --no-pager
```

## デザイン言語

- 見た目の統一感を最重要視する
- Pixel Perfect を目指す
- 要素のサイズ変更のアニメーションは行わない (美しくないので)
- Apple の Liquid Glass を模倣する

