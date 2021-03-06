githubへのssh接続設定
--------

1. ssh公開鍵・秘密鍵作成
    (略)
2. 公開鍵をGitHubに登録
    (略)
3. .ssh/config設定
```
Host github github.com
  HostName github.com
  IdentityFile ~/.ssh/id_git_rsa #登録した公開鍵に対応する秘密鍵を指定
  User git
```
4. 接続確認
```
$ ssh -T git@github.com
```
or
```
ssh -T github
```

a. githubのリポジトリへのssh接続設定
--------

a. リポジトリへの接続設定(リポジトリ名/.git/configの設定)
```
git remote set-url origin git@github.com:[gihubユーザ名]/[gihubリポジトリ].git
```

b. githubのリポジトリへのssh接続設定
--------

```
git remote add origin https://github.com/[gihubユーザ名]/[gihubリポジトリ].git
```

```
vim ~/.gitconfig

### 以下を追記
[url "github:"]
	InsteadOf = https://github.com/
	InsteadOf = git@github.com:
```
 or 
```
git config --global "url.git@github.com:.pushinsteadof" "https://github.com/"
```

※初回のみ
```
git push --set-upstream origin master

or 

git push -u origin master
```
