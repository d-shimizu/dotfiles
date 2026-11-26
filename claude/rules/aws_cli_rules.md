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
>
> ### 環境(dev / stg / prd など)ごとに切り替える場合
>
> - 1 セッションで扱う環境は 1 つとし、切り替えは再起動で行う(会話中の切り替えは受け付けない)
> - 環境ごとの settings ファイルを用意し、起動時に `--settings` で渡す
>   - 配置: `<project>/.claude/aws/<env>.json`(git 管理外。チームでプロファイル名を共有する場合のみ git 管理下に置く)
>   - 起動: `claude --settings .claude/aws/stg.json`
> - 環境を切り替えるプロジェクトでは `settings.json` / `settings.local.json` に `AWS_PROFILE` を書かない
>   - 既定の環境があると、`--settings` を付け忘れたときにその環境で黙って起動してしまうため
>   - 付け忘れた場合は `AWS_PROFILE` が未設定になり、AWS を操作しない(下記ルールで止まる)
> - プロファイル名には環境名を含める(例: `myproject-prd-claude-ro`)
> - prd 環境では read-only のプロファイルのみ使う
>
> 例: `.claude/aws/stg.json`
>
> ```json
> { "env": { "AWS_PROFILE": "myproject-stg-claude-ro" } }
> ```

- AWS を操作する際は **環境変数 `AWS_PROFILE` で指定されたプロファイルのみ使用可能**
  - AWS CLI に限らず、SDK・Terraform・AWS MCP サーバーなど AWS 認証情報を使うすべての操作に適用する
- セッションで最初に AWS を操作する前に、プロファイル名・アカウント・ロールをユーザーに示す
  - SessionStart フック(`~/.claude/hooks/aws-session-identity.sh`)が `AWS_PROFILE` 設定時に `aws sts get-caller-identity` の結果をコンテキストに注入するので、その結果を使う
  - フックの結果がコンテキストに無い場合(フック未設定の環境など)は、`echo $AWS_PROFILE` と `aws sts get-caller-identity` を実行して確認する
  - フックの結果が認証失敗の場合は「認証エラー時」に従う
- `AWS_PROFILE` が未設定の場合は AWS を操作せず、ユーザーに報告する
  - 報告時は上記の指定先に `env.AWS_PROFILE` を設定するか、`AWS_PROFILE=<profile> claude` で再起動するよう案内する
  - `<project>/.claude/aws/` に環境別の settings ファイルがある場合は、`claude --settings .claude/aws/<env>.json` で再起動するよう案内する
  - AWS MCP の API 実行ツール(`run_script` / `get_presigned_url`)は PreToolUse フック(`~/.claude/hooks/aws-mcp-require-profile.sh`)でブロックされる。ブロックされた場合に別の手段で回避しない
- 以下は禁止する
  - `--profile` オプションでのプロファイル指定
  - `AWS_PROFILE` / `AWS_DEFAULT_PROFILE` の上書き・unset
  - Claude が settings ファイル(`~/.claude/settings*.json`, `<project>/.claude/settings*.json`, `<project>/.claude/aws/*.json`)の `AWS_PROFILE` を追加・変更すること(設定はユーザーが行う)
  - `AWS_ACCESS_KEY_ID` などの認証情報を環境変数で直接設定すること
  - `~/.aws/credentials` や `~/.aws/sso/cache` の読み取り、`~/.aws/config` の編集、`aws configure` の実行
- AWS MCP サーバー(aws-core プラグイン)はツール呼び出しごとにプロファイルを指定できず、起動時の環境の `AWS_PROFILE` で署名する想定である。そのため使う前に、MCP の `sts GetCallerIdentity` の結果が上記で確認したアカウント・ロールと一致するか確認する。一致しなければ使わずにユーザーに報告する

## 認証エラー時

- SSO セッション切れなどで認証に失敗した場合、別のプロファイルで再試行しない
- ユーザーに `! aws sso login` の実行を依頼する(`AWS_PROFILE` のプロファイルでログインされる)
