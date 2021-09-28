let g:ale_set_balloons = 1
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

syntax enable

" Commands
nnoremap <C-\> :Vista!!<CR>
nnoremap <C-P> :ALEGoToDefinition<CR>
nnoremap <Leader>vf :Vista finder fzf<CR>
nnoremap ; :Files<cr>

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

nnoremap <Leader>b :Buffers<cr>
nnoremap <Leader>s :BLines<cr>

nnoremap <silent> <Leader>gr :Rg <C-R><C-W><CR>

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
call plug#begin('~/.vim/plugged')
" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'peterhoeg/vim-qml'
Plug 'junegunn/fzf.vim'
Plug 'chriskempson/base16-vim'
Plug 'rust-lang/rust.vim'
Plug 'tomtom/tcomment_vim'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'liuchengxu/vista.vim'
Plug 'codota/tabnine-vim'
Plug 'bfrg/vim-cpp-modern'
if has('nvim') || has('patch-8.0.902')
    Plug 'mhinz/vim-signify'
else
    Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

call plug#end()
"
"
" Colors
" set Vim-specific sequences for RGB colors
if $TERM =~# '256color' && ( $TERM =~# '^screen'  || $TERM =~# '^tmux' )
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
" points to current base16-shell profile, requires 256 color supported terminal
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif


" fzf.vim
"
set rtp+=~/.fzf
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   "rg --column --line-number --no-heading --color=always --smart-case -g '!tags' -g '!tools' -g '!.build/*' -g '!_Document/*' -g '!tests/*' -g '!TestGui/*' ".shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%', '?')
            \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%'),
            \   <bang>0)


" Preview window on the upper side of the window with 40% height,
" ctrl-/ to toggle hidden
let g:fzf_preview_window = ['up:40%', 'ctrl-/']

" Lightline
"
let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'readonly', 'filename', 'modified', 'method' ] ],
            \   'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
            \            [ 'lineinfo' ],
            \            [ 'percent' ],
            \            [ 'fugitive', 'fileformat', 'fileencoding', 'filetype' ] ],
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
            \   'method': 'NearestMethodOrFunction',
            \   'fugitive': 'FugitiveHead'
            \ },
            \ }

" Vista.vim
"
let g:vista_default_executive = 'ale'
let g:vista#renderer#enable_icon = 0
let g:vista_close_on_jump = 1
let g:vista_fzf_preview = ['up:50%']
let g:vista_sidebar_open_cmd = '50vsplit'

" vim-cpp-modern
"
" Enable highlighting of C++11 attributes
let g:cpp_attributes_highlight = 1

" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 1

" Ale
"
let g:ale_linters = {
            \ 'cpp': ['clangd'],
            \ 'c': ['clangd'],
            \ 'python': [],
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

let g:ale_c_parse_compile_commands = 1

