# dotfiles

## Dependencies
* neovim 6+
* vim 8.0+
* tmux 2.9+
* terminal w/ 256 color support (alacritty recommended)
* zsh

## Cloning
Cloning this directly is not recommended unless you are me.

add to .zshrc or .bashrc and source:
```bash
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

And clone:
```bash
echo ".cfg" >> .gitignore
git clone --bare --recursive <URL> $HOME/.cfg
config checkout
```

Reduce status spam:
```bash
config config --local status.showUntrackedFiles no
```

Init submodules:
```bash
config submodule init
config submodule update
```

## Install
* run neovim to install fzf and neovim plugins: `:PlugInstall`, to update: `:PlugUpdate` and `:PlugUpgrade`
* run tmux and install the plugins `ctrl+a I`, to update: `ctrl+a U`

