" General Settings
" some of this is vim-airline specific
set showmatch
set cursorline
set mouse=a
set laststatus=2
set noshowmode
set ruler
set lazyredraw
set magic
set showmatch
set mat=2
set hidden
set history=100
" for 'set list', visualizes whitepsace
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set splitbelow
set splitright
set tags=./tags,tags;$HOME

" Columns
set colorcolumn=80
set number

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch

" Tabs
filetype indent on
set nowrap
set smartindent
set autoindent
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" Colors
syntax enable
" points to current base16-shell profile, requires 256 color supported terminal
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif

" Commands
map ; :Files<CR>
command W w !sudo tee % > /dev/null

" Plugins
packadd termdebug
set rtp+=~/.fzf

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   "rg --column --line-number --no-heading --color=always --smart-case -g '!tags' -g '!tools' -g '!.build/*' -g '!_Document/*' -g '!tests/*' -g '!TestGui/*' -g '!DisplayService/Hawk/*' -g '!DisplayService/Osprey/*' -g '!DisplayService//*' -g '!DisplayService//*' ".shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)

let g:ale_linters = {
            \ 'cpp': ['cppcheck', 'gcc'],
            \ 'c': ['cppcheck', 'gcc'],
            \ 'python': ['flake8'],
            \ 'rust': ['cargo'],
            \}

let g:ale_fixers = {
\   'rust': ['rustfmt'],
\}

let g:ale_set_highlights = 0

let g:ale_c_cppcheck_options = '--enable=style,warning,performance -i tools -i .build -i _Document -i tests -i tags -i .git -i .svn'
let g:ale_cpp_cppcheck_options = '--enable=style,warning,performance -i tools -i .build -i _Document -i tests -i tags -i .git -i .svn'


" Osprey GCC linting
" let g:ale_cpp_gcc_executable = '/opt/raptor/dev-osprey-v0003-20190304/sysroots/i686-raptorsdk-linux/usr/bin/arm-oe-linux-gnueabi/arm-oe-linux-gnueabi-g++'
" let g:ale_cpp_gcc_options = '-c -Wall -fmessage-length=0 -march=armv7-a -marm -mthumb-interwork -mfloat-abi=hard -mfpu=neon -mtune=cortex-a9 -O0 -g3 -fstack-protector-all -Wstack-protector --sysroot=/opt/raptor/dev-osprey-v0003-20190304/sysroots/cortexa9hf-neon-oe-linux-gnueabi -Wno-psabi -std=gnu++14 -pthread -DENG_BUILD -DRAPTOR_PLATFORM_OSPREY=1 -DRAPTOR_PLATFORM="OSPREY" -DRAPTOR_PRODUCT_OSPREY=1 -DRAPTOR_PRODUCT="OSPREY" -DRAPTOR_PRODUCTPLATFORM_OSPREY=1 -DRAPTOR_PRODUCTPLATFORM="OSPREY" -DRAPTOR_VARIANT_DEBUG=1 -DRAPTOR_VARIANT_INT=1 -DRAPTOR_VARIANT_EVE=1 -DRAPTOR_VARIANTS=\"DEBUG,INT,EVE\" -DRAPTOR_VARIANTS_BRIEF=\"INT-EVE\" -DFEATURE_AUTOMATED_TEST -DFEATURE_CONTINUOUS_MODE -DFEATURE_VSC_MODE -DFEATURE_HOME_MODE -DFEATURE_CCHD_MODE -DRAPTOR_STATS=1 -DRAPTOR_BSP_SDK_OE_CORE_PYRO=1 -DRAPTOR_DATA_DIR=''"/opt/raptor/share"'' -D_REENTRANT -DQT_SHARED -DQ_MASIMO -DQ_RAPTOR_DATA_PATH=\"/opt/raptor/share/\" -Irad_infrastructure -I.build/Osprey-Debug-INT-EVE/include -I/opt/raptor/dev-osprey-v0003-20190304/sysroots/cortexa9hf-neon-oe-linux-gnueabi/usr/include/qt5/QtQuick -I/opt/raptor/dev-osprey-v0003-20190304/sysroots/cortexa9hf-neon-oe-linux-gnueabi/usr/include/qt5 -I/opt/raptor/dev-osprey-v0003-20190304/sysroots/cortexa9hf-neon-oe-linux-gnueabi/usr/include/qt5/QtQml -I/opt/raptor/dev-osprey-v0003-20190304/sysroots/cortexa9hf-neon-oe-linux-gnueabi/usr/include/qt5/QtNetwork -I/opt/raptor/dev-osprey-v0003-20190304/sysroots/cortexa9hf-neon-oe-linux-gnueabi/usr/include/qt5/QtTest -I/opt/raptor/dev-osprey-v0003-20190304/sysroots/cortexa9hf-neon-oe-linux-gnueabi/usr/include/qt5/QtPrintSupport -I/opt/raptor/dev-osprey-v0003-20190304/sysroots/cortexa9hf-neon-oe-linux-gnueabi/usr/include/qt5/QtWidgets -I/opt/raptor/dev-osprey-v0003-20190304/sysroots/cortexa9hf-neon-oe-linux-gnueabi/usr/include/qt5/QtGui -I/opt/raptor/dev-osprey-v0003-20190304/sysroots/cortexa9hf-neon-oe-linux-gnueabi/usr/include/qt5/QtCore -I/opt/raptor/dev-osprey-v0003-20190304/sysroots/cortexa9hf-neon-oe-linux-gnueabi/usr/include/qt5/QtCore/5.6.3/QtCore -I/opt/raptor/dev-osprey-v0003-20190304/sysroots/cortexa9hf-neon-oe-linux-gnueabi/usr/include/qt5/QtGui/5.6.3/QtGui -I/opt/raptor/dev-osprey-v0003-20190304/sysroots/cortexa9hf-neon-oe-linux-gnueabi/usr/include/qt5/QtQuick/5.6.3/QtQuick -I/opt/raptor/dev-osprey-v0003-20190304/sysroots/cortexa9hf-neon-oe-linux-gnueabi/usr/include/qt5/QtGui/5.6.3 -I/opt/raptor/dev-osprey-v0003-20190304/sysroots/cortexa9hf-neon-oe-linux-gnueabi/usr/include/qt5/QtQuick/5.6.3 -Irad_upgrade -Irad_model -Irad_rpc -Irad_event -Irad_infrastructure -IDisplayService/Base -IDisplayService/Base/Qt5x -I/opt/raptor/dev-osprey-v0003-20190304/sysroots/cortexa9hf-neon-oe-linux-gnueabi/usr/include/gstreamer-1.0 -I/opt/raptor/dev-osprey-v0003-20190304/sysroots/cortexa9hf-neon-oe-linux-gnueabi/usr/include/glib-2.0 -I/opt/raptor/dev-osprey-v0003-20190304/sysroots/cortexa9hf-neon-oe-linux-gnueabi/usr/lib/glib-2.0/include -IModelService -IDockingStation -IInstrumentStateService -IParamBoardService -Imbdhost -Imbdhost2 -Imbdhost2/reg -IAudioService -IAlarmAggregator -IServiceManager -ITrendService -IGatewayService -IHardwareManagerService -IMIBService -IProxyService -INibpService -INibpService/Externals/stbpi -ICradleService -IIndicators -IPrinterService -INetworkManagerService -Irad_service -I.build/Osprey-Debug-INT-EVE/DisplayService/Osprey/include -IDisplayService/Osprey/include -I.build/Osprey-Debug-INT-EVE/DisplayService/Osprey/moc -IDisplayService/Osprey/moc -I.build/Osprey-Debug-INT-EVE/DisplayService/Osprey -IDisplayService/Osprey'

