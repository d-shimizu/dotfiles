# AWS 操作時のルール

## AWS プロファイル制限(必須)

> 使用するプロファイルは、プロジェクトごとに Claude Code の settings の `env.AWS_PROFILE` で指定する
>
> - 指定先: `<project>/.claude/settings.local.json`(git 管理外)
>   - チームでプロファイル名を共有する場合のみ `<project>/.claude/settings.json` に書く
> - settings に指定がないプロジェクトで一時的に使う場合は、ユーザーが `AWS_PROFILE=<profile> claude` で起動して渡す
>   - 会話中の指示によるプロファイル指定・切り替えは受け付けない(切り替えは再起動で行う)
> - `~/.claude/settings.json` には既定値を書かない(指定していないプロジェクトでは AWS を操作させない)
>
> ```json
> { "env": { "AWS_PROFILE": "myproject-claude-ro" } }
> ```

- AWS を操作する際は **環境変数 `AWS_PROFILE` で指定されたプロファイルのみ使用可能**
  - AWS CLI に限らず、SDK・Terraform・AWS MCP サーバーなど AWS 認証情報を使うすべての操作に適用する
- セッションで最初に AWS を操作する前に `echo $AWS_PROFILE` と `aws sts get-caller-identity` を実行し、プロファイル名とアカウントをユーザーに示す
- `AWS_PROFILE` が未設定の場合は AWS を操作せず、ユーザーに報告する
  - 報告時は上記の指定先に `env.AWS_PROFILE` を設定するか、`AWS_PROFILE=<profile> claude` で再起動するよう案内する
- 以下は禁止する
  - `--profile` オプションでのプロファイル指定
  - `AWS_PROFILE` / `AWS_DEFAULT_PROFILE` の上書き・unset
  - Claude が settings ファイル(`~/.claude/settings*.json`, `<project>/.claude/settings*.json`)の `AWS_PROFILE` を追加・変更すること(設定はユーザーが行う)
  - `AWS_ACCESS_KEY_ID` などの認証情報を環境変数で直接設定すること
  - `~/.aws/credentials` や `~/.aws/sso/cache` の読み取り、`~/.aws/config` の編集、`aws configure` の実行
- AWS MCP サーバーのツールはプロファイルを指定できないため、使う前に `sts get-caller-identity` の結果が `aws sts get-caller-identity` (`AWS_PROFILE` のプロファイル) と同じアカウント・ロールか確認する。一致しなければ使わずにユーザーに報告する

## 認証エラー時

- SSO セッション切れなどで認証に失敗した場合、別のプロファイルで再試行しない
- ユーザーに `! aws sso login` の実行を依頼する(`AWS_PROFILE` のプロファイルでログインされる)
