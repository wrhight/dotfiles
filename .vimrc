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
  \   "rg --column --line-number --no-heading --color=always --smart-case -g '!tags' -g '!tools' -g '!.build/*' -g '!_Document/*' -g '!tests/*' -g '!DisplayService/Eagle/*' -g '!DisplayService/Hawk/*' ".shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)

let g:ale_linters = {
            \ 'cpp': ['cppcheck', 'gcc'],
            \ 'c': ['cppcheck', 'gcc'],
            \ 'python': ['flake8'],
            \}

let g:ale_c_cppcheck_options = '--enable=style,warning,performance -i tools -i .build -i _Document -i tests -i tags -i .git -i .svn'
let g:ale_cpp_cppcheck_options = '--enable=style,warning,performance -i tools -i .build -i _Document -i tests -i tags -i .git -i .svn'

