call plug#begin('~/.config/nvim/autoload')
Plug 'mhinz/vim-startify'

Plug 'tamarin-prover/editors'

Plug 'LnL7/vim-nix'

Plug 'ziglang/zig.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lervag/vimtex'

Plug 'morhetz/gruvbox'

"tmux integration
Plug 'christoomey/vim-tmux-navigator'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug  'honza/vim-snippets'

"Navigation
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'majutsushi/tagbar'

Plug 'junegunn/fzf', {'do' : { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'antoinemadec/coc-fzf'

Plug 'vim-scripts/a.vim'

Plug 'mbbill/undotree'

"Python specific
Plug 'nvie/vim-flake8'

"Git specific
Plug 'tpope/vim-fugitive'

"markdown 
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'gaoDean/autolist.nvim'

"Searching in files
Plug 'mileszs/ack.vim'

"Formatting
Plug 'junegunn/vim-easy-align'
Plug 'Raimondi/delimitMate'
Plug 'kylechui/nvim-surround'

"concealing
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}

Plug 'github/copilot.vim', {'as': 'copilot'}

call plug#end()


"Encoding
set encoding=utf-8
set fileencoding=utf-8

"Mappings
let mapleader = ","
let maplocalleader = ","
map Q gq
nmap <F3> :set hlsearch!<CR>
nmap <F4> :set relativenumber!<CR>
nmap <F4> :TagbarToggle!<CR>
imap <C-BS> <C-W>

"accommodate to german keyboard
nmap ß ^
nnoremap + *
nnoremap * #
imap „ ^

nmap <leader>u :UndotreeToggle<CR>:UndotreeFocus<CR>

"run script
"nmap <F7> :!sh run.sh <CR>
"nmap <F6> :cgetexpr system('sh run.sh test')<CR>:cw<CR>
"cmake option

nmap <F7> :!cmake --build build --target run<CR>
nmap <F6> :!cmake --build build --target utests<CR>

tnoremap <Esc> <C-\><C-n>

nmap <c-n> :cnext<CR>
nmap <c-p> :cprev<CR>
"repeat last command in tmux pane
nmap <leader>rp :!tmux send-keys -t {last} UP Enter <CR> <CR>

"configuration

"use global statusline
"set laststatus=3
"highlight WinSeperator guifg=None

set autoindent
set cinoptions=(0
set cindent
setlocal cindent cino=j1,(0,ws,Ws

set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

set nu
set lazyredraw
set relativenumber

set ignorecase "usefult in combination with set smartcase
set smartcase

set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

"cmake integration
set makeprg=make\ -C\ build
command! Cmake !mkdir -p build && pushd build && cmake .. && popd

""""""""""""""""""""""
"Plugin configuration"
""""""""""""""""""""""
lua require("nvim-surround").setup({ })

lua require("autolist").setup({ })

let g:instant_markdown_mathjax = 1
"let g:instant_markdown_mermaid = 1

let g:airline_powerline_fonts              = 1
let g:airline_theme                        = 'base16_grayscale'
let g:airline_extensions=['coc', 'branch', 'fugitiveline']

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

set termguicolors
let g:gruvbox_contrast_dark="hard"
autocmd vimenter * ++nested colorscheme gruvbox
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
endfunction
"FZF config
let g:fzf_action = {
    \ 'ctrl-q': function('s:build_quickfix_list'),
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'window': { 'width': 0.95, 'height': 0.8 } }
let g:fzf_preview_window = ['up:50%', 'ctrl-/']

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

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
autocmd! User FzfStatusLine call <SID>fzf_statusline()

"fzf mappings
"find open buffers
nnoremap <silent>; :Buffers<CR>
"find inside open buffers
nnoremap <silent><C-g> :Lines<CR>
"grep from working dir
nnoremap <C-a> :Rg<Cr>
"fuzzy find files
nmap <C-f> :FZF<CR>
"fuzzy find git files
nnoremap <C-p> :GitFiles <CR>

"fuzzyocList symbols
nmap <C-s> :CocFzfList symbols<CR>

nmap <silent> <F4> :TagbarToggle<CR>
nmap <silent> <F2> :NERDTreeToggle<CR>

"copilot 
highlight CopilotSuggestion guifg=#555555 ctermfg=8
imap <silent><script><expr> <C-A> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

"COC configuration


autocmd FileType json syntax match Comment +\/\/.\+$+

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `leader-next / leader-previous´ to navigate diagnostics
nmap <silent> <leader>n <Plug>(coc-diagnostic-next)
nmap <silent> <leader>p <Plug>(coc-diagnostic-prev)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" map function and class text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
nnoremap <silent> <space>l  :<C-u>CocFzfList<cr>
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocFzfList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocFzfList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocFzfList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>s  :<C-u>CocFzfList symbols<CR>
" Find outline of current document.
nnoremap <silent> <space>o  :<C-u>CocFzfList outline<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
noremap <silent> <space>p  :<C-u>CocFzfListResume<CR>

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

"vimtex
let g:vimtex_view_method = 'mupdf'
let g:vimtex_view_mupdf_send_keys=''
let g:tex_flavor = "latex"

"GIT
nmap <leader>gs :Gstatus<CR>

"conceal
"tex
let g:tex_superscripts= "[0-9a-zA-W.,:;+-<>/()=]"
let g:tex_subscripts= "[0-9aehijklmnoprstuvx,+-/().]"
let g:tex_conceal_frac=1
set conceallevel=2
let g:tex_conceal="abdgm"

"tex
let g:vimtex_format_enabled=1

let g:tex_comment_nospell=0

augroup Latex
autocmd!
autocmd BufNewFile,BufRead *.tex setlocal filetype=tex
augroup END

"staritfy
let g:startify_bookmarks = [ 
            \ {'T' : '~/todo.md'}, 
            \ {'V': '~/.config/nvim/init.vim'}, 
            \ {'I': '~/i3/i3/config'}, 
            \ {'Z': '~/.zshrc'}
            \ ]


filetype plugin on
