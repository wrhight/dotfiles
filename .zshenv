fpath=( "$HOME/.zfunctions" $fpath )
export EDITOR=vim
export KEYTIMEOUT=1
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow -g '!.git/*'"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export PATH=$PATH:~/.cargo/bin

