#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#

autoload -U compinit
compinit
zstyle ':completion:*:default' menu select=1

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

## keep background processes at full speed
#setopt NOBGNICE
## restart running processes on exit
#setopt HUP

## history
#setopt APPEND_HISTORY
## for sharing history between zsh processes
#setopt INC_APPEND_HISTORY
#setopt SHARE_HISTORY

## never ever beep ever
#setopt NO_BEEP

## automatically decide when to page a list of completions
#LISTMAX=0

## disable mail checking
#MAILCHECK=0

# autoload -U colors
#colors


## Default shell configuration
#
# set prompt
#
case ${UID} in
0)     # root (uid=0)
    PROMPT="%B%{[35m%}%/#%{[m%}%b "
    PROMPT2="%B%{[35m%}%_#%{[m%}%b "
    SPROMPT="%B%{[35m%}%r is correct? [n,y,a,e]:%{[m%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[35m%}${USER}@${HOST%%.*} ${PROMPT}"
    ;;
*)     # not root (uid!=0)
    #PROMPT="%{[0;0m%}%/%%%{[m%} "
    PROMPT="%{[0;0m%}%~ %%%{[m%} "
    PROMPT2="%{[0;0m%}%_%%%{[m%} "
    SPROMPT="%{[0;0m%}%r is correct? [n,y,a,e]:%h[m%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        #PROMPT="%{[36m%} %D %T %{[35m%}${USER}@${HOST%%.*} ${PROMPT}"

        PROMPT="%{[0;0m%}%D{%Y/%m/%d %T} ${HOST%%.*} ${PROMPT}"
        #PROMPT="%{[0;0m%}%D{%Y/%m/%d %T} CentOS6 ${PROMPT}"
        #PROMPT="%{[1;35m%}%D{%Y/%m/%d %T} ${HOST%%.*} ${PROMPT}"

        #PROMPT="%{[1;35m%}%D{%Y/%m/%d %T} ${USER}@${HOST%%.*} ${PROMPT}"
        #PROMPT="%{[1;36m%}%D{%Y/%m/%d %T} %{[35m%}${USER}@${HOST%%.*} ${PROMPT}"
        #PROMPT="%{[1;35m%}${USER}@${HOST%%.*} ${PROMPT}"
        #PROMPT="%{[36m%}${USER}@${HOST%%.*} ${PROMPT}"
    ;;
esac

# set terminal title including current directory
#

case "${TERM}" in
kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac 


# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no beep sound when complete list displayed
#
setopt nolistbeep

## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes 
#   to end of it)
#
bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

## Completion configuration
#
autoload -U compinit
compinit

#if [ $SHLVL = 1 ]; then
#    alias tmux="tmux new-session \; source-file ~/tmux/.tmux.session"
#fi
#alias tmux="tmux new-session \; source-file ~/tmux/.tmux.session"
#export SCREENRC="${SCREENRC:-$HOME/.screenrc}"
export COLORFGBG='15;0'
##printf "\033k$HOSTNAME\033\\"

## LANG
#
LANG=ja_JP.UTF-8

## EDITOR
#
EDITOR=vim

export LANG EDITOR
