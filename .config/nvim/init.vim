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
set laststatus=3

" Columns
set colorcolumn=80
set number

" Search
set ignorecase
set smartcase

" Tabs
set breakindent
set updatetime=100
set smartindent
set expandtab
set shiftwidth=4
set tabstop=4

" For polyglot
set nocompatible

" Commands
command W SudaWrite

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
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat' " for lightspeed
Plug 'liuchengxu/vista.vim'
Plug 'fidian/hexmode'
Plug 'joshdick/onedark.vim'
Plug 'lambdalisue/suda.vim'
Plug 'sheerun/vim-polyglot'
Plug 'lervag/vimtex'
Plug 'fatih/vim-go'

" Neovim specific
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tversteeg/registers.nvim', { 'branch': 'main' }
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'kyazdani42/nvim-tree.lua'
Plug 'ggandor/lightspeed.nvim'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }

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
if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
    set termguicolors
endif

syntax on
autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight PMenu ctermbg=NONE guibg=NONE
colorscheme onedark

" lualine
lua << END
require('lualine').setup {
    options = {
        theme = 'onedark',
        icons_enabled = false,
    }
}
END

" commentary
lua require('Comment').setup()

" Telescope
" 
lua << EOF
require('telescope').load_extension('fzf')
require('telescope').setup({
defaults = {
    layout_strategy='vertical',
    mappings = {
        i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
        },
    }
},
})
EOF

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>ss <cmd>Telescope live_grep<cr>
nnoremap <leader>gs <cmd>Telescope grep_string<cr>
nnoremap <leader>gr <cmd>Telescope lsp_references<cr>
nnoremap <leader>rr <cmd>Telescope resume<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

command -nargs=* Rg :call luaeval('require("telescope.builtin").grep_string({search=_A})', expand('<args>'))
" command -nargs=* Rg :Telescope grep_string search=<args>

" nvim-tree
"
nnoremap <C-\> :NvimTreeFindFileToggle<CR>
lua require'nvim-tree'.setup()

" Vista.vim
"
let g:vista_default_executive = 'nvim_lsp'
let g:vista#renderer#enable_icon = 1
let g:vista_close_on_jump = 1
let g:vista_fzf_preview = ['up:50%']
let g:vista_sidebar_open_cmd = '50vsplit'

" lspconfig
"
" let g:coq_settings = { 'auto_start': 'shut-up' }
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
local servers = { 'clangd', 'gopls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup(coq.lsp_ensure_capabilities {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  })
end

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- rust is a special child
local opts = {
    server = coq.lsp_ensure_capabilities {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        }
    }
}

require('rust-tools').setup(opts)
EOF

" gitsigns
"

lua << EOF
require('gitsigns').setup()
EOF

" vimtex
"
" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
let g:vimtex_view_method = 'zathura'

" vim-go
"
let g:go_gopls_enabled = 0

" IDK ANYMORE
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=250}
augroup END

