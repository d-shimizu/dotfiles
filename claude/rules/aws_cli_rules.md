# AWS 操作時のルール

## AWS プロファイル制限(必須)

> プロファイル名 `claude-code-ro` は環境に合わせて書き換えて使う

- AWS を操作する際は **`claude-code-ro` プロファイルのみ使用可能**
  - AWS CLI に限らず、SDK・Terraform・AWS MCP サーバーなど AWS 認証情報を使うすべての操作に適用する
- 環境変数 `AWS_PROFILE` が設定済みとは限らないため、AWS CLI では毎回 `--profile claude-code-ro` を明示する
- 以下は禁止する
  - `claude-code-ro` 以外のプロファイルの指定(`--profile` / `AWS_PROFILE` / `AWS_DEFAULT_PROFILE`)
  - `AWS_ACCESS_KEY_ID` などの認証情報を環境変数で直接設定すること
  - `~/.aws/credentials` や `~/.aws/sso/cache` の読み取り、`~/.aws/config` の編集、`aws configure` の実行
- AWS MCP サーバーのツールはプロファイルを指定できないため、使う前に `sts get-caller-identity` で `claude-code-ro` のプロファイルと同じアカウント・ロールか確認する。一致しなければ使わずにユーザーに報告する

## 認証エラー時

- SSO セッション切れなどで認証に失敗した場合、別のプロファイルで再試行しない
- ユーザーに `! aws sso login --profile claude-code-ro` の実行を依頼する
