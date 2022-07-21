# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
setopt appendhistory sharehistory incappendhistory autocd extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
fpath+=$HOME/.zplugins/pure

autoload -U promptinit; promptinit
prompt pure

if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [ "$(command -v zoxide)" ]; then
    eval "$(zoxide init zsh)"
fi

# Keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

autoload -U zkbd
if [[ -f ${ZDOTDIR:-$HOME}/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE} ]]; then
    source ${ZDOTDIR:-$HOME}/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
else
    echo "WARNING: Keybindings may not be set correctly!"
    echo "Execute \`zkbd\` to create bindings."
fi

[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-beginning-search
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-beginning-search
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" up-line-or-beginning-search
[[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" down-line-or-beginning-search

# better faster stronger
alias spm='sudo pacman'
alias pc="picocom -e b -b 115200 $1"
alias ls="ls -CF --color=auto"
alias ll='ls -FGlAhp'
alias less='less -FSRXc'

alias pacs='yay -Slq | fzf -m --preview 'yay -Si {1}'| xargs -ro yay -S'
alias pacr='yay -Qeq | fzf -m --preview 'yay -Qi {1}' | xargs -ro yay -Rs'

# For dotfile repo
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

stty -ixon

n()
{
    nnn "$@"

    NNN_TMPFILE=$HOME/.config/nnn/.lastd

    if [ -f $NNN_TMPFILE ]; then
        . $NNN_TMPFILE
        rm $NNN_TMPFILE
    fi
}

# For delta
compdef _gnu_generic delta

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

