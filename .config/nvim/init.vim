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
if (!exists('g:vscode'))
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-obsession'
    Plug 'tpope/vim-rhubarb'
endif
Plug 'tpope/vim-repeat' " for lightspeed
Plug 'liuchengxu/vista.vim'
Plug 'fidian/hexmode'
Plug 'lambdalisue/suda.vim'
Plug 'lervag/vimtex'
Plug 'fatih/vim-go'

" Neovim specific
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'olimorris/onedarkpro.nvim'
Plug 'RRethy/nvim-base16'
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
if (!exists('g:vscode'))
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
endif
Plug 'ggandor/leap.nvim'
Plug 'romgrk/barbar.nvim'
Plug 'lukas-reineke/lsp-format.nvim'

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
" autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
" autocmd ColorScheme * highlight PMenu ctermbg=NONE guibg=NONE
colorscheme onedark

" tree-sitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "go", "yaml", "javascript", "typescript" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

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
    layout_strategy='horizontal',
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
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>s <cmd>Telescope live_grep<cr>
nnoremap <leader>gs <cmd>Telescope grep_string<cr>
nnoremap gr <cmd>Telescope lsp_references<cr>
nnoremap <leader>i <cmd>Telescope lsp_implementations<cr>
nnoremap <leader>r <cmd>Telescope resume<cr>
nnoremap <leader>h <cmd>Telescope help_tags<cr>

command -nargs=* Rg :call luaeval('require("telescope.builtin").grep_string({search=_A})', expand('<args>'))
" command -nargs=* Rg :Telescope grep_string search=<args>

" nvim-tree
"
if (!exists('g:vscode'))
    nnoremap <C-\> :NvimTreeFindFileToggle<CR>
    lua require'nvim-tree'.setup()
endif

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
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  -- done via Telescope
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

  require("lsp-format").on_attach(client, bufnr)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'clangd', 'gopls', 'tsserver' }
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

require("lspconfig").gopls.setup { on_attach = on_attach }
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

" leap
lua require('leap').add_default_mappings()

" IDK ANYMORE
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=250}
augroup END

