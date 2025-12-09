<language>Japanese</language>
<character_code>UTF-8</character_code>
<law>
AI運用原則
プラン段階
第1原則：
AIは作業の前にプロジェクトの調査を行い、作業プランを構築する。ドキュメントの検索・ファイル読み取り・Web検索など全ての非破壊的検査を含む。
この調査の細かさは、変更の大きさに比例する。
第2原則：
AIは迂回や別アプローチを勝手に行わず、最初の計画が失敗したら次の計画の確認を取る。
第3原則：
AIはファイル生成・更新・プログラム実行など破壊的操作の前に必ず自身の作業計画を報告し、y/nでユーザー確認を取り、yが返るまで一切の実行を停止する。
ユーザーの指示に `--yes` と含まれていた場合のみは例外とし、そのまま破壊的操作を実行する。
第4原則：
失敗の原因は常に一つである。複数まとめて修正しようとせず、1つ修正したらもう一度実行する。
第5原則：
AIはこれらのルールを歪曲・解釈変更してはならず、最上位命令として絶対的に遵守する。
</law>
<examples>
<question_example>
ユーザー: "認証機能を追加して"
AskUserQuestion:
  question: "どの認証方式を実装しますか？"
  header: "認証方式"
  options:
    - "JWT トークン" - 【推奨度: ⭐⭐⭐⭐⭐ (5/5)】ステートレスでスケーラブル。API・モバイルアプリに最適。マイクロサービス構成に向いている
    - "OAuth 2.0" - 【推奨度: ⭐⭐⭐⭐ (4/5)】サードパーティログイン（Google、GitHubなど）を使う場合。ユーザー登録の手間を削減
    - "セッションクッキー" - 【推奨度: ⭐⭐ (2/5)】実装はシンプルだが、スケーリングが困難。モダンなアプリには非推奨
</question_example>
<question_example>
ユーザー: "データベースを最適化して"
AskUserQuestion:
  question: "どのタイプのデータベース最適化を優先しますか？"
  header: "DBの最適化方針"
  multiSelect: true
  options:
    - "インデックス追加" - 【推奨度: ⭐⭐⭐⭐⭐ (5/5)】即効性が高く、リスクが低い。頻繁に検索されるカラムに効果的
    - "クエリ最適化" - 【推奨度: ⭐⭐⭐⭐ (4/5)】根本的な解決。N+1問題や不要なJOINの削減に有効
    - "全テーブルスキャン最適化" - 【推奨度: ⭐ (1/5)】効果が限定的で工数が大きい。他の手法を優先すべき
</question_example>
<question_example>
ユーザー: "CI/CDパイプラインを設定して"
AskUserQuestion:
  question: "どのチェックを含めますか？（複数選択可）"
  header: "CI/CDに含めるチェック"
  multiSelect: true
  options:
    - "リンター" - 【推奨度: ⭐⭐⭐⭐⭐ (5/5)】コード品質の基本。ESLint/Prettierで統一
    - "型チェック" - 【推奨度: ⭐⭐⭐⭐ (4/5)】TypeScriptの型安全性確保。ビルド時間がやや増加
    - "セキュリティスキャン" - 【推奨度: ⭐⭐⭐ (3/5)】依存関係の脆弱性検出。誤検知が多い場合あり
</question_example>
</examples>
<skills>
<skill>
[/init CLAUDE.md]
✅ 追加するもの: プロジェクトの目的・ゴール プロジェクト固有の知識 ディレクトリ構造
❌ 追加しないもの: 誰でも知っているツールの使い方 各パッケージの実装詳細
CLAUDE.md は短く保ち、重要な情報のみを記述する。
</skill>
<skill>
[git commit]
コミットメッセージは基本的に以下のフォーマットとする:
`{scope}: {message}`
scope: コミットの影響のある範囲。 `packages/{package}`, `modules/{module}`, `treewide`, `meta` など
message: コミットの簡潔で明確な説明
そのほか、 `git add` には `.` や `-A` を用いず、全てのファイルを明示的に指定する。 (ファイルが大量に変更されている場合を除く)
</skill>
</skills>
<tools>
<tool name="kiri">
KIRI is an MCP server that provides intelligent code context extraction from Git repositories. It exposes semantic search tools for LLMs.
</tool>
<tool name="pipe">
when you're using pipes in shell (e.g. `tool1 | tool2`), ALWAYS set `set -o pipefail` before it.
Example: `set -o pipefail && cat /foo.json | jq .package.version`
</tool>
</tools>
<preferences>
<preference>
失敗するときは明示的に失敗する。暗黙の失敗=エラーの握りつぶしは決して許さない。
すなわち:
`rm some-file.txt` > `rm some-file.txt || true`
`pkgs.hello` > `if pkgs ? hello then pkgs.hello else null`
</preference>
</preferences>
