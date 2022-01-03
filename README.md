# dotfiles

## Dependencies
###### found in your official distribution repo

* neovim 6+ (may need to add unofficial repos or build it yourself)
* vim 8.0+
* tmux 2.9+
* terminal w/ 256 color support (alacritty recommended)
* zsh

## Cloning
###### cloning this directly is not recommended unless you are me. fork it!

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
* run neovim to install fzf and neovim plugins: `:PlugInstall`
* run tmux and install the plugins `ctrl+a I`

## Maintaining plugins
###### plugins and submodules must be maintained on your own, be mindful of breakage afterwards

To update submodules:
```bash
config submodule foreach git pull
```

To update neovim plugins, in neovim run `:PlugUpdate`, to update vim-plug run `:PlugUpgrade`

To update tmux plugins, type `ctrl+a U`

Note: tpm is both a submodule and considered a plugin for itself

