" ============================================================================
" General settings
" ============================================================================
set nocompatible              " Use Vim defaults, not Vi
set encoding=utf-8            " UTF-8 encoding
set fileencoding=utf-8        " File encoding
set history=1000              " Command history
set hidden                    " Allow switching buffers without saving
set autoread                  " Reload files changed outside vim
set backspace=indent,eol,start " Backspace works as expected

" ============================================================================
" UI settings
" ============================================================================
set number                    " Show line numbers
set relativenumber            " Relative line numbers (hybrid with number)
set cursorline                " Highlight current line
set showcmd                   " Show incomplete commands
set showmode                  " Show current mode
set laststatus=2              " Always show status line
set ruler                     " Show cursor position
set wildmenu                  " Command-line completion menu
set wildmode=longest:full,full
set scrolloff=5               " Keep 5 lines above/below cursor
set sidescrolloff=5           " Keep 5 columns left/right of cursor
set signcolumn=auto           " Show sign column when needed

" ============================================================================
" Colors and syntax
" ============================================================================
syntax enable                 " Enable syntax highlighting
set background=dark           " Dark background
set termguicolors             " True color support (if terminal supports it)
colorscheme desert            " Built-in colorscheme that works everywhere

" ============================================================================
" Search
" ============================================================================
set incsearch                 " Search as you type
set hlsearch                  " Highlight search results
set ignorecase                " Case-insensitive search...
set smartcase                 " ...unless uppercase is used
" Press <leader>/ to clear search highlighting
nnoremap <leader>/ :nohlsearch<CR>

" ============================================================================
" Indentation
" ============================================================================
set autoindent                " Copy indent from current line
set smartindent               " Smart autoindenting for C-like languages
set expandtab                 " Use spaces instead of tabs
set tabstop=4                 " Tab displays as 4 spaces
set shiftwidth=4              " Indent with 4 spaces
set softtabstop=4             " Tab key inserts 4 spaces
filetype plugin indent on     " Enable filetype detection and indentation

" ============================================================================
" Performance
" ============================================================================
set lazyredraw                " Don't redraw during macros
set ttyfast                   " Faster terminal connection

" ============================================================================
" Backup and swap
" ============================================================================
set nobackup                  " Don't create backup files
set nowritebackup             " Don't create backup before overwriting
set noswapfile                " Don't create swap files
set undofile                  " Persistent undo
set undodir=~/.vim/undodir    " Undo directory

" Create undo directory if it doesn't exist
if !isdirectory($HOME . "/.vim/undodir")
    call mkdir($HOME . "/.vim/undodir", "p")
endif

" ============================================================================
" Key mappings
" ============================================================================
" Set leader key to space
let mapleader = " "

" Quick save
nnoremap <leader>w :w<CR>

" Quick quit
nnoremap <leader>q :q<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Move lines up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Keep visual selection when indenting
vnoremap < <gv
vnoremap > >gv

" Y yanks to end of line (consistent with C and D)
nnoremap Y y$

" ============================================================================
" Filetype-specific settings
" ============================================================================
augroup filetypes
    autocmd!
    " 2-space indent for certain filetypes
    autocmd FileType javascript,typescript,json,yaml,html,css,scss setlocal tabstop=2 shiftwidth=2 softtabstop=2
    " Python
    autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
    " Makefiles need real tabs
    autocmd FileType make setlocal noexpandtab
augroup END

" ============================================================================
" Netrw (built-in file explorer)
" ============================================================================
let g:netrw_banner = 0        " Hide banner
let g:netrw_liststyle = 3     " Tree view
let g:netrw_winsize = 25      " Width percentage
