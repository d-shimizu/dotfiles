#!/usr/bin/env bash
# PreToolUse(Bash) hook:
# Claude が Bash 経由で Claude Code の settings ファイル(.claude/settings*.json)を
# 書き換えるのをブロックする。読み取り(cat, jq での参照など)は許可する。
#
# permissions.deny の Edit(...) はファイル編集ツールにしか効かないため、その補完。
# ヒューリスティックなので、難読化されたコマンドまでは防げない。
set -euo pipefail

cmd=$(jq -r '.tool_input.command // empty')
[ -z "$cmd" ] && exit 0

# settings ファイルに触れていなければ対象外
printf '%s' "$cmd" | grep -Eq '\.claude/settings[^[:space:]"'\'']*\.json' || exit 0

# 書き込みを示すパターン
write_pattern='(>|>>)[[:space:]]*[^[:space:]&|;]*\.claude/settings'          # リダイレクト
write_pattern+='|\b(sed|perl|ruby)\b[^|;&]*[[:space:]]-[a-zA-Z]*i'             # インプレース編集
write_pattern+='|\b(tee|cp|mv|rm|ln|install|truncate|dd|rsync|sponge|chmod|chown)\b'
write_pattern+='|\b(python3?|node|ruby|perl|osascript)\b[^|;&]*[[:space:]]-(c|e)\b' # ワンライナー
write_pattern+='|\b(vi|vim|nvim|nano|emacs|ed|ex)\b'                           # エディタ

if printf '%s' "$cmd" | grep -Eq "$write_pattern"; then
  echo "Blocked: Claude Code の settings ファイル(.claude/settings*.json)を Bash で書き換えることは禁止されています。変更はユーザーが手動で行ってください。" >&2
  exit 2
fi

exit 0
