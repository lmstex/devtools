set nocompatible

filetype off
set runtimepath+=~/.vim

" required for the Ctrlp plugin
set runtimepath^=~/.vim/bundle/ctrlp.vim

" activates the pathogen plugin
" runtime autoload/pathogen.vim
"execute pathogen#infect()

set rtp+=~/.vim/bundle/Vundle.vim
syntax on

" activates the vundle plugin
call vundle#begin()

  Plugin 'VundleVim/Vundle.vim'
  Plugin 'tmhedberg/SimpylFold'
  Plugin 'vim-scripts/indentpython.vim'
  Bundle 'Valloric/YouCompleteMe'
  Plugin 'vim-syntastic/syntastic'
  Plugin 'nvie/vim-flake8'
  Plugin 'jnurmine/Zenburn'
  Plugin 'altercation/vim-colors-solarized'
  Plugin 'scrooloose/nerdtree'
  Plugin 'kien/ctrlp.vim'
  Plugin 'vim-airline/vim-airline'
  Plugin 'vim-airline/vim-airline-themes'
  " add more Vundle plugins here

call vundle#end()

filetype plugin indent on

set modelines=0

set number relativenumber

set ruler

set visualbell

set encoding=utf-8

set wrap 
set textwidth=85
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:>
runtime! macros/matchit.vim

nnoremap <space> za

nnoremap j gj
nnoremap k gk

set hidden

set ttyfast

set laststatus=2

set showmode
set showcmd

" inoremap / /\v
" vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase 
set showmatch
map <leader><space> :let @/=''<cr>

inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

map <leader>q gqip

set t_Co=256
set background=dark

" solarized color scheme is available in
" https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized


" Ctrlp configurations
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" YouCompleteMe settings
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Nerdtree settings
nnoremap <C-t> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" Airline configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '>'
" let g:airline#extensions#tabline#formatter = 'default'

" Python settings
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=85
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix
    \ set foldmethod=indent
    \ set foldlevel=99

python3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

" HTML and javascript settings
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2
    \ set textwidth=120
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix
    \ set foldmethod=indent
    \ set foldlevel=99
