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
  Plugin 'iamcco/markdown-preview.nvim' 
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

" inoremap <F1> <ESC>:set invfullscreen<CR>a
" nnoremap <F1> :set invfullscreen<CR>
" vnoremap <F1> :set invfullscreen<CR>

map <leader>q gqip

set t_Co=256
set background=dark

set spell spelllang=en_us
set directory^=$HOME/.vim/swap//

" solarized color scheme is available in
" https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized
let g:ctrlp_custom_ignore = ''

" Ignore everything inside any obj directory
set wildignore+=*/obj,tags

" Ctrlp configurations
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_show_hidden = 1

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
    \ softtabstop=4
    \ shiftwidth=4
    \ textwidth=85
    \ colorcolumn=85
    \ expandtab
    \ autoindent
    \ fileformat=unix
    \ foldmethod=indent
    \ foldlevel=99 



python3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    exec(compile(open(activate_this, "rb").read(), activate_this, 'exec'),  dict(__file__=activate_this))
    # execfile(activate_this, dict(__file__=activate_this))
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

" Markdown preview settings
let g:mkdp_auto_start = 0
let g:mkdp_browser = ''
nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle

" Configurarion (.conf) file settings
autocmd BufNewFile,BufRead *.conf set syntax=sh

nmap <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

if !empty(expand(glob("$REPO_DIR/.vimrc")))
  source $REPO_DIR/.vimrc
endif
