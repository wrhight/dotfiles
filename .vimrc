" General Settings
" some of this is vim-airline specific
set showmatch
set cursorline
set mouse=a
set ttymouse=sgr
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
" set Vim-specific sequences for RGB colors
if $TERM =~# '256color' && ( $TERM =~# '^screen'  || $TERM =~# '^tmux' )
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

syntax enable
" points to current base16-shell profile, requires 256 color supported terminal
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif

" Commands
nnoremap <C-\> :Vista!!<CR>
nnoremap <C-P> :ALEGoToDefinition<CR>
nnoremap <Leader>vf :Vista finder fzf<CR>
nnoremap ; :Files<cr>

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

nnoremap <Leader>b :Buffers<cr>
nnoremap <Leader>s :BLines<cr>

nnoremap <silent> <Leader>gr :Rg expand("<cword>")

command W w !sudo tee % > /dev/null

if executable("rg")
    set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow\ --ignore
endif

function! NearestMethodOrFunction() abort
    return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" Plugins
packadd termdebug

" FZF
set rtp+=~/.fzf
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" Lightline
let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'readonly', 'filename', 'modified', 'method' ] ],
            \   'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
            \            [ 'lineinfo' ],
            \            [ 'percent' ],
            \            [ 'fileformat', 'fileencoding', 'filetype'] ],
            \ },
            \ 'component_expand': {
            \  'linter_checking': 'lightline#ale#checking',
            \  'linter_infos': 'lightline#ale#infos',
            \  'linter_warnings': 'lightline#ale#warnings',
            \  'linter_errors': 'lightline#ale#errors',
            \  'linter_ok': 'lightline#ale#ok',
            \ },
            \ 'component_type': {
            \     'linter_checking': 'right',
            \     'linter_infos': 'right',
            \     'linter_warnings': 'warning',
            \     'linter_errors': 'error',
            \     'linter_ok': 'right',
            \ },
            \ 'component_function': {
            \   'method': 'NearestMethodOrFunction'
            \ },
            \ }

" Vista.vim
let g:vista_default_executive = 'ale'
let g:vista#renderer#enable_icon = 0

" vim-cpp-modern
" Enable highlighting of C++11 attributes
let g:cpp_attributes_highlight = 1

" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 1

" fzf
" command! -bang -nargs=* Rg
"             \ call fzf#vim#grep(
"             \   "rg --column --line-number --no-heading --color=always --smart-case -g '!tags' -g '!tools' -g '!.build/*' -g '!_Document/*' -g '!tests/*' -g '!TestGui/*' -g '!DisplayService/Hawk/*' -g '!DisplayService/Osprey/*' -g '!DisplayService//*' -g '!DisplayService//*' ".shellescape(<q-args>), 1,
"             \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
"             \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
"             \   <bang>0)

" Ale
let g:ale_linters = {
            \ 'cpp': ['clangd', 'clangtidy', 'clang-check', 'cppcheck'],
            \ 'c': ['clangd', 'clangtidy', 'cppcheck'],
            \}
"
" let g:ale_fixers = {
"             \   'rust': ['rustfmt'],
"             \}
"
let g:ale_set_highlights = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1

let g:ale_c_cppcheck_options = '--enable=warning,style,performance,information,missingInclude --std=c99 --platform=unix32'
let g:ale_cpp_cppcheck_options = '--enable=warning,style,performance,information,missingInclude --std=c++14 --platform=unix32'

let g:ale_c_build_dir = '.build'

" Eagle GCC linting
let g:ale_cpp_gcc_executable = '/opt/raptor/dev-eagle-v0003-20210506/sysroots/i686-raptorsdk-linux/usr/bin/arm-oe-linux-gnueabi/arm-oe-linux-gnueabi-g++'
let g:ale_c_gcc_executable = '/opt/raptor/dev-eagle-v0003-20210506/sysroots/i686-raptorsdk-linux/usr/bin/arm-oe-linux-gnueabi/arm-oe-linux-gnueabi-gcc'

" Osprey GCC linting
" let g:ale_cpp_gcc_executable = '/opt/raptor/dev-osprey-v0003-20190304/sysroots/i686-raptorsdk-linux/usr/bin/arm-oe-linux-gnueabi/arm-oe-linux-gnueabi-g++'

let g:ale_c_parse_compile_commands = 1

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL

