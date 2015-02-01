# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# User specific aliases and functions


### Environment variable configuration
# LANG
export LANG=ja_JP.UTF-8

# bash History
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTCONTROL=ignoredups
export HISTIGNORE=?:??:exit
export HISTFILE=~/.bash_history/.bash_history-$OSTYPE-`date +%Y%m%d`

# Editor Env
export EDITOR=vim


### Prompt configuration
case ${UID} in
0)
    PS1='\[\033[1;31m\]${PWD}\$\[\033[0m\] '
    PS2='\[\033[1;31m\]>\[\033[0m\] '
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PS1='\[\033[1;36m\]\h'" ${PS1}"
    ;;
*)
    PS1='\[\033[37m\]\w \$\[\033[0m\] '
    PS2='\[\033[37m\]$\[\033[0m\] '
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PS1='\[\036[33m\]\D{%F} \t ${USER}@\h'" ${PS1}"
    ;;
esac

### set terminal title including current directory
case "${TERM}" in
kterm*|xterm)
    PROMPT_COMMAND='echo -e "\033]0;'"${USER}@`awk '{ print $1,$2,$5 }' /etc/system-release`"'${PWD}\007\c"'
    ;;
esac


### Readline configuration
[ -f ~/.inputrc ] && bind -f ~/.inputrc

### Original configuration
[ -f ~/.bashrcx ] && source ~/.bashrcx
