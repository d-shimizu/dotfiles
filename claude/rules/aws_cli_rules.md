# AWS 操作時のルール

## AWS プロファイル制限(必須)

> 使用するプロファイル名は環境ごとに `~/.claude/settings.json` の `env.AWS_PROFILE` で指定する
>
> ```json
> { "env": { "AWS_PROFILE": "claude-code-ro" } }
> ```

- AWS を操作する際は **環境変数 `AWS_PROFILE` で指定されたプロファイルのみ使用可能**
  - AWS CLI に限らず、SDK・Terraform・AWS MCP サーバーなど AWS 認証情報を使うすべての操作に適用する
- `AWS_PROFILE` が未設定の場合は AWS を操作せず、ユーザーに報告する
- 以下は禁止する
  - `--profile` オプションでのプロファイル指定
  - `AWS_PROFILE` / `AWS_DEFAULT_PROFILE` の上書き・unset
  - `AWS_ACCESS_KEY_ID` などの認証情報を環境変数で直接設定すること
  - `~/.aws/credentials` や `~/.aws/sso/cache` の読み取り、`~/.aws/config` の編集、`aws configure` の実行
- AWS MCP サーバーのツールはプロファイルを指定できないため、使う前に `sts get-caller-identity` の結果が `aws sts get-caller-identity` (`AWS_PROFILE` のプロファイル) と同じアカウント・ロールか確認する。一致しなければ使わずにユーザーに報告する

## 認証エラー時

- SSO セッション切れなどで認証に失敗した場合、別のプロファイルで再試行しない
- ユーザーに `! aws sso login` の実行を依頼する(`AWS_PROFILE` のプロファイルでログインされる)
