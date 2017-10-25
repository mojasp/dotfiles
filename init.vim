call plug#begin('~/.config/nvim/autoload')
Plug 'freitass/todo.txt-vim'

Plug 'altercation/vim-colors-solarized'

Plug 'christoomey/vim-tmux-navigator'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'majutsushi/tagbar'
"Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'Valloric/YouCompleteMe' | Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'xolox/vim-easytags' | Plug 'xolox/vim-misc'
Plug 'vim-scripts/cpp_cppcheck.vim'
Plug 'vim-scripts/a.vim'

Plug 'nvie/vim-flake8'

Plug 'tpope/vim-fugitive'

Plug 'mileszs/ack.vim'

Plug 'junegunn/vim-easy-align'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
call plug#end()

"Mappings
let mapleader = ","
let maplocalleader = ","
map Q gq
nmap <F3> :set hlsearch!<CR>
nmap <F4> :set relativenumber!<CR>
nmap <F4> :TagbarToggle!<CR>
imap <C-BS> <C-W>

nmap <F7> :!sh run.sh <CR>
nmap <F6> :cgetexpr system('sh run.sh test')<CR>:cw<CR>

tnoremap <Esc> <C-\><C-n>

nmap <c-n> :cnext<CR>
nmap <c-p> :cprev<CR>
"repeat last command in tmux pane
nmap <leader>r :!tmux send-keys -t 0:0.1 UP Enter <CR> 

"configuration

set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

set autoindent
set cinoptions=(0
set cindent

set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab

set nu
set lazyredraw
set relativenumber

set ignorecase "usefult in combination with set smartcase
set smartcase

set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set hlsearch		"highlightsearch by default

"add errorfmt for doctest
set efm+=%f(%l)\ %m

"Plugin configuration
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

let g:solarized_termcolors=256
set background=dark
colorscheme solarized

let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-a>"
let g:UltiSnipsJumpBackwardTrigger="<c-y>"
let g:UltiSnipsEditSplit="vertical"

let g:ycm_collect_identifiers_from_tags_files = 1
let g:easytags_async = 1
let g:ycm_filetype_blacklist = {
        \ 'tagbar' : 1,
        \ 'qf' : 1,
        \ 'notes' : 1,
        \ 'markdown' : 1,
        \ 'unite' : 1,
        \ 'text' : 1,
        \ 'vimwiki' : 1,
        \ 'pandoc' : 1,
        \ 'infolog' : 1,
        \ 'mail' : 1
        \}
let g:ycm_confirm_extra_conf = 0

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

"FZF
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" You can set up fzf window using a Vim command (Neovim or latest Vim 8 required)
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10split enew' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

"Plugin mappings
nmap <silent> <leader>q :YcmCompleter GetDoc<CR>
nmap <silent> <leader>w :YcmCompleter GoTo <CR>
nmap <silent> <leader>c :YcmCompleter FixIt <CR>


nmap <silent> <F4> :TagbarToggle<CR>
nmap <silent> <F2> :NERDTreeToggle<CR>

"load saerchresult files in quickfix list
nnoremap <leader>a :Ack 
"fuzzy find files
nmap <leader>f :FZF<CR>
"fuzzy find inside file
nmap <leader>s :Ag<CR> 
nmap ; :Buffers<CR>
