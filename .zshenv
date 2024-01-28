export KEYTIMEOUT=1
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow -g '!.git/*' -g '!.cfg/*' -g '!.wine/*' -g '!.npm/*' -g '!.cache/*'"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export PATH="$HOME/bin:$PATH"
export PATH=$PATH:~/.cargo/bin
export PATH="/home/$USER/.git-fuzzy/bin:/home/$USER/.local/bin:$PATH"
export MAKEFLAGS="-j$(expr $(nproc) \+ 1)"
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
export QT_QPA_PLATFORMTHEME=gtk2
export BROWSER="/usr/local/bin/firefox"
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus

export BAT_THEME="base16"
export LESS=-RS

#export QT_QPA_PLATFORM=wayland
#export QT_WAYLAND_FORCE_DPI=physical

export QT_AUTO_SCREEN_SCALE_FACTOR=1

