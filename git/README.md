---
* 公開鍵・秘密鍵作成
* 公開鍵をGitHubに登録
* .ssh/config設定
```
Host github github.com
  HostName github.com
  IdentityFile ~/.ssh/id_git_rsa #ここに自分の鍵のファイル名
  User git
```
* 接続確認
```
$ ssh -T git@github.com
```
or
```
ssh -T github
```

## リポジトリへの接続

* リポジトリへの接続設定
```
git remote set-url origin git@github.com:[gihubユーザ名]/[gihubリポジトリ].git
```
* gitconfig設定
```:~/.gitconfig
[url "github:"]
	InsteadOf = https://github.com/
	InsteadOf = git@github.com:
```
or
```
git config --global "url.git@github.com:.pushinsteadof" "https://github.com/"
```



