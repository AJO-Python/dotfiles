set nocompatible " be iMproved, required
filetype off " required

if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    " means ctrl-arrow works correctly
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin('~/.vim/plugged')
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kh3phr3n/python-syntax'
Plug 'plasticboy/vim-markdown'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'unblevable/quick-scope'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()            " required

xmap ga <Plug>(EasyAlign)
" " NERDtree config
" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" Spell check commits and max width 80 chars
autocmd FileType gitcommit setlocal spell tw=80

" If another buffer tries to replace NERDTree, put it in the other window, and
" bring back NERDTree.
"autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif


nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)


"Remap space to leader
nnoremap <SPACE> <Nop>
"nnoremap <SPACE> :wa<CR>
let mapleader=" "
nnoremap <silent> <LEADER>f :Files<CR>
nnoremap <silent> <C-f> :Rg<CR>
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" sudo save
cmap w!! w !sudo tee % >/dev/null

" open and reload vimrc from anywhere
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>rv :so $MYVIMRC<CR>

" Get into nerdree
nnoremap <LEADER>n :NERDTreeFocus<CR>

" fold all with space+enter
nnoremap <LEADER><CR> za

set autoindent
set background=dark
set backspace=indent,eol,start
set breakindent
set colorcolumn=120
set copyindent
set expandtab
set foldlevelstart=6
set foldmethod=indent
set hidden
set history=1000
set incsearch
set laststatus=2
set linebreak
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set mouse=a
set nobackup
set noerrorbells
set noswapfile
set number relativenumber
set ruler
set scrolloff=8
set shiftround
set shiftwidth=2
set smartcase
set smarttab
set softtabstop=4
set splitbelow
set splitright
set tabstop=4
set title
set undodir=~/.vim/undodir
set undofile
set wildmenu
set wildmode=longest,list:longest
set wildignore=*.swp,*.bak,*.pyc,*.class
set wrap
" Puts two spaces before a wrapped line
let &showbreak="  "

syntax on
filetype plugin indent on
autocmd FileType css setlocal shiftwidth=2 expandtab tabstop=2 softtabstop=2

set hlsearch
" Clears search highlighting and resets last command
nnoremap <CR> :noh<CR>:<backspace>

" Setup cursor appearance
" Toggle cursor position highlighting
" colorscheme slate 
hi CursorLine cterm=NONE ctermbg=67 ctermfg=white
"guibg=darkred guifg=white
noremap <leader>: :set cursorline! cursorcolumn!<CR>

" Start new line at bottom of file
map <leader>g Go

" quickfix fun
nnoremap <LEADER>co :copen<CR>
nnoremap <LEADER>cc :cclose<CR>
nnoremap <LEADER>> :cnext<CR>
nnoremap <LEADER>< :cprev<CR>

" Move window with space and directions
" noremap <leader>l <C-w>l
" noremap <leader>k <C-w>k
" noremap <leader>j <C-w>j
" noremap <leader>h <C-w>h

noremap <leader><LEFT>  <C-w>h
noremap <leader><DOWN>  <C-w>j
noremap <leader><UP>    <C-w>k
noremap <leader><RIGHT> <C-w>l

" Better movement over wrapped lines
nnoremap <DOWN> gj
nnoremap <UP> gk

" Easier movement
noremap K {
noremap J }
noremap H ^
noremap L $

noremap <C-UP> {
noremap <C-DOWN> }
noremap <C-LEFT> ^
noremap <C-RIGHT> $

" Movement in insert mode
inoremap <C-h> <LEFT>
inoremap <C-j> <DOWN>
inoremap <C-k> <UP>
inoremap <C-l> <RIGHT>

" Closes current buffer and opens previous one back up (Basically preserves
" split panes
noremap <C-x> :bp<Bar>bd #<Cr>

" Typing a pair of punctuation moves the cursor back inside that punctuation
"inoremap <> <><LEFT>
"inoremap () ()<LEFT>
"inoremap {} {}<LEFT>
"inoremap [] []<LEFT>
"inoremap '' ''<LEFT>
"inoremap `` ``<LEFT>

" Save files quicker
noremap <leader>w :wa<cr>
noremap <leader>W :wqa<cr>

" Indent using TAB and S-TAB
nnoremap <TAB> >>
nnoremap <S-TAB> <<
inoremap <S-TAB> <ESC><<i
vnoremap <TAB> >><ESC>gv
vnoremap <S-TAB> <<<ESC>gv

" quit file easily
nnoremap <leader>q :q<cr>
nnoremap <leader>Q :q!<cr>

nnoremap <leader>v <c-v>
nnoremap <C-#> <esc>I# <esc>j

" leader commands
nnoremap <leader>; :Limelight!!<cr>
xnoremap <leader>p "_dP
" Run macros with Q
nnoremap Q @q

" Consistent Y (yanks till end of line)
nnoremap Y y$

" Make w act like iw
onoremap w iw
onoremap W iW

" YOUTUBE VIMRC FEATURES
" use :find folder/*
" :b autocomplete jump to any open buffer
set path+=**

" SNIPPETS
" PYTHON
let python_highlight_all = 1
nnoremap <leader>e <esc>:w<CR>:!./%<CR>

" Better undo breakpoints
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
inoremap <CR> <CR><c-g>u


" markdown code block syntax highlighting
let g:markdown_fenced_languages=['html', 'python', 'bash', 'vim', 'json', 'yaml']
" limelight conceal colour config
let g:limelight_conceal_ctermfg=244
autocmd FileType markdown let b:sleuth_automatic=0
autocmd FileType markdown let conceallevel=0
autocmd FileType markdown normal zR

let g:vim_markdown_frontmatter=1
let g:vim_markdown_toml_frontmatter=1
let g:vim_markdown_json_frontmatter=1
let g:vim_markdown_strikethrough=1
let g:vim_markdown_new_list_item_indent=2

let g:mkdp_refresh_slow=1

