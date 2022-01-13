" General Settings
set showmatch
set cursorline
set mouse=a
set noshowmode
set showmatch
" for 'set list', visualizes whitepsace
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set splitbelow
set splitright
set updatetime=100

" Columns
set colorcolumn=80
set number

" Search
set ignorecase
set smartcase

" Tabs
set nowrap
set smartindent
set expandtab
set shiftwidth=4
set tabstop=4

" Commands
nnoremap <C-\> :Vista!!<CR>
nnoremap <Leader>vf :Vista finder fzf<CR>
nnoremap ; :Files<cr>

nnoremap <Leader>b :Buffers<cr>
nnoremap <Leader>s :BLines<cr>

nnoremap <silent> <Leader>gr :Rg <C-R><C-W><CR>

command W w !sudo tee % > /dev/null

if executable("rg")
    set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow\ --ignore
endif

" Plugins
"

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')
" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-commentary'
Plug 'peterhoeg/vim-qml'
Plug 'junegunn/fzf.vim'
Plug 'fnune/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'daviesjamie/vim-base16-lightline'
Plug 'liuchengxu/vista.vim'
Plug 'bfrg/vim-cpp-modern'

" Neovim specific
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'RRethy/nvim-base16'

Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'} " Snippets
Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
" - shell repl
" - nvim lua api
" - scientific calculator
" - comment banner
" - etc
call plug#end()
"
"
" Colors
" set Vim-specific sequences for RGB colors
" if $TERM =~# '256color' && ( $TERM =~# '^screen'  || $TERM =~# '^tmux' )
"     let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"     let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"     set termguicolors
" endif
" points to current base16-shell profile, requires 256 color supported terminal
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif

"
" vim-cpp-modern
"
" Enable highlighting of C++11 attributes
let g:cpp_attributes_highlight = 1

" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 1

" Disable function highlighting (affects both C and C++ files)
let g:cpp_function_highlight = 1

" fzf.vim
"
set rtp+=~/.fzf
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   "rg --column --line-number --no-heading --color=always --smart-case -g '!tags' -g '!tools' -g '!.build/*' -g '!_Document/*' -g '!tests/*' -g '!TestGui/*' ".shellescape(<q-args>), 1,
            \   fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Rge
            \ call fzf#vim#grep(
            \   "rg --column --line-number --no-heading --color=always --smart-case -g '!tags' -g '!tools' -g '!.build/*' -g '!_Document/*' -g '!tests/*' -g '!TestGui/*' -g '!DisplayService/Osprey/*' -g '!DisplayService/Hawk/*' ".shellescape(<q-args>), 1,
            \   fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Rgo
            \ call fzf#vim#grep(
            \   "rg --column --line-number --no-heading --color=always --smart-case -g '!tags' -g '!tools' -g '!.build/*' -g '!_Document/*' -g '!tests/*' -g '!TestGui/*' -g '!DisplayService/Eagle/*' -g '!DisplayService/Hawk/*' ".shellescape(<q-args>), 1,
            \   fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Rgh
            \ call fzf#vim#grep(
            \   "rg --column --line-number --no-heading --color=always --smart-case -g '!tags' -g '!tools' -g '!.build/*' -g '!_Document/*' -g '!tests/*' -g '!TestGui/*' -g '!DisplayService/Eagle/*' -g '!DisplayService/Osprey/*' ".shellescape(<q-args>), 1,
            \   fzf#vim#with_preview(), <bang>0)

" call fzf#vim#grep("rg --column --line-number --no-heading --color=always
" --smart-case -- ".shellescape(<q-args>), 1, fzf#vim#with_pre
" view(), <bang>0)

" Preview window on the upper side of the window with 40% height,
" ctrl-/ to toggle hidden
let g:fzf_preview_window = ['up:40%', 'ctrl-/']
"
" nvim-base16
"
lua << EOF
vim.cmd('colorscheme base16-schemer-dark')
EOF

" Lightline
"
let g:lightline = {
            \ 'colorscheme' : 'base16',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'readonly', 'filename', 'modified' ] ],
            \   'right': [
            \            [ 'lineinfo' ],
            \            [ 'percent' ],
            \            [ 'fugitive', 'fileformat', 'fileencoding', 'filetype' ] ],
            \ },
            \ 'component_function': {
            \   'fugitive': 'FugitiveHead'
            \ },
            \ }

" Vista.vim
"
let g:vista_default_executive = 'nvim_lsp'
let g:vista#renderer#enable_icon = 1
let g:vista_close_on_jump = 1
let g:vista_fzf_preview = ['up:50%']
let g:vista_sidebar_open_cmd = '50vsplit'

" lspconfig
"
let g:coq_settings = { 'auto_start': 'shut-up' }
lua << EOF
local nvim_lsp = require('lspconfig')
local coq = require('coq')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'clangd' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup(coq.lsp_ensure_capabilities {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  })
end
EOF

" gitsigns
"

lua << EOF
require('gitsigns').setup()
EOF

