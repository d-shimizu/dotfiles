# dotfiles

個人用の設定ファイル置き場。

## 構成

| ディレクトリ | 内容 | 配置先 |
| --- | --- | --- |
| `zsh/` | zsh 設定・git プロンプト | `~/.zshrc`, `~/.git-prompt.sh` |
| `bash/` | bash 設定・readline 設定 | `~/.bashrc`, `~/.inputrc` |
| `tcsh/` | tcsh 設定 | `~/.tcshrc` |
| `vim/` | Vim 設定 | `~/.vimrc` |
| `.config/nvim/` | Neovim 設定 | `~/.config/nvim/` |
| `tmux/` | tmux 設定・起動用スクリプト | `~/.tmux.conf` |
| `git/` | git 設定のサンプル・GitHub への SSH 接続手順（[git/README.md](git/README.md)） | `~/.gitconfig` |
| `.ssh/` | SSH 設定のサンプル | `~/.ssh/config` |
| `claude/` | Claude Code のユーザー共通指示（`CLAUDE.md`）とルール（`rules/`） | `~/.claude/CLAUDE.md`, `~/.claude/rules` |

## セットアップ

シンボリックリンクを張って使う。

```sh
DOTFILES=~/workspace/github.com/d-shimizu/dotfiles

ln -s $DOTFILES/zsh/.zshrc ~/.zshrc
ln -s $DOTFILES/vim/.vimrc ~/.vimrc
ln -s $DOTFILES/.config/nvim ~/.config/nvim
ln -s $DOTFILES/tmux/.tmux.conf ~/.tmux.conf

# Claude Code
ln -s $DOTFILES/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -s $DOTFILES/claude/rules ~/.claude/rules
```

`*.example` のファイルはユーザー名やホスト名などがダミー値になっているため、コピーしてから環境に合わせて編集する（`git/config.example` は各リポジトリの `.git/config` のサンプル）。

```sh
cp $DOTFILES/git/.gitconfig.example ~/.gitconfig
cp $DOTFILES/.ssh/config.example ~/.ssh/config
```
