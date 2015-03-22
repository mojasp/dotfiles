"installing this setup:
"1) $ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"2) $ vim -c "PluginInstall"
"3) $ cd ~/.vim/bundle/vim-colors-solarized/colors
"4) $ mv solarized.vim ~/vim/colors
"
"for youcompleteme:
"5) build ycm: https://github.com/Valloric/YouCompleteMe#ubuntu-linux-x64-super-quick-installation
"6) configure ycm (->:help youcompleteme)

"vundle
set nocp
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/nerdtree'
Plugin 'godlygeek/tabular'
Plugin 'majutsushi/tagbar'
Plugin 'SirVer/ultisnips'
Plugin 'bling/vim-bufferline'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'tpope/vim-fugitive'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/syntastic'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator'

call vundle#end()
filetype plugin indent on

syntax on		"syntax highlighting
set backspace=indent,eol,start
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
set nu
set relativenumber

set lazyredraw


let mapleader=","

map Q gq
set ignorecase "usefult in combination with set smartcase
set smartcase 
set cino+=(0
set backupdir=~/.vim/backups "dont clutter working directories
set history=700		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set visualbell		" visual bell
set autochdir		"working directory = current directory
set hlsearch		"highlightsearch by default
set autoindent		" always set autoindenting on


"wrapping
set wrap
set cpo=n
if has('gui_running')
	let &showbreak = '↳ '
else
	let &showbreak = '> '
endif

"listchars, ':set list' to enable
set listchars=eol:$,tab:\|\ ,trail:~

"fileytype
filetype plugin on 
filetype indent on

"mappings
nmap <silent> <F1> :TagbarToggle<CR>
nmap <silent> <F2> :NERDTreeToggle<CR>
nmap <F3> :set hlsearch!<CR>
nmap <F4> :set relativenumber!<CR>
imap <C-BS> <C-W>

nmap <leader>p :w<CR>:make<CR>
nmap <leader>e :!sh ./run.sh<CR>
nmap <leader>d :!gdb ./%<<CR>

nmap <C-N> :cn<CR>
nmap <C-P> :cp<CR>

"tag - mappings
nmap <A-t> <C-]>
nmap <A-ß> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"windows
map <TAB> <C-W>w
map <S-TAB> <C-W>W

"buffers
map <silent> <C-RIGHT> :w<CR>:bn<CR>
map <silent> <C-LEFT> :w<CR>:bp<CR>
map <silent> <RIGHT> :bn<CR>
map <silent> <LEFT> :bp<CR>

"Vertical Split Buffer Function (with Vbuffer)
function VerticalSplitBuffer(buffer)
    execute "vert belowright sb" a:buffer 
endfunction
command -nargs=1 Vbuffer call VerticalSplitBuffer(<f-args>)
command -nargs=1 Vb call VerticalSplitBuffer(<f-args>)


"plugins
"
let NERDTreeQuitOnOpen=1

"delimitMate
let delimitMate_expand_cr = 1

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_extra_conf_globlist = ['~/dev/*','~/Documents/*']

"UltiSnips
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"

"gui
if has('gui_running')
	set background=dark
	colorscheme solarized
	set guifont=Courier\ 10\ Pitch\ 10
	set go-=L
	set go-=T
	set go-=m
	set go-=r
else
endif
