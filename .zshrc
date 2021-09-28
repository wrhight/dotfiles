# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
setopt appendhistory sharehistory incappendhistory autocd extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
fpath+=$HOME/.zplugins/pure

autoload -U promptinit; promptinit
prompt pure

# Keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

autoload -U zkbd
source ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-beginning-search
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-beginning-search
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" up-line-or-beginning-search
[[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" down-line-or-beginning-search

alias pc="picocom -e b -b 115200 $1"
alias ls="ls -CF --color=auto"

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

stty -ixon

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'


n()
{
    nnn "$@"

    NNN_TMPFILE=$HOME/.config/nnn/.lastd

    if [ -f $NNN_TMPFILE ]; then
        . $NNN_TMPFILE
        rm $NNN_TMPFILE
    fi
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

