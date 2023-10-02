set nocompatible " be iMproved, required
filetype off " required

call plug#begin('~/.local/share/nvim/site/autoload/plug.vim')
Plug 'roxma/nvim-completion-manager'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
call plug#end()
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'preservim/nerdtree'
Plugin 'davidhalter/jedi-vim'
Plugin 'kh3phr3n/python-syntax'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'junegunn/limelight.vim'
call vundle#end()            " required

" " NERDtree config
" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" If another buffer tries to replace NERDTree, put it in the other window, and
" bring back NERDTree.
"autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Get into nerdree
nnoremap <leader>n :NERDTreeFocus<CR>

" JediVim mappings (DEFAULTS)
" let g:jedi#goto_assigments_command = "<leader>g" -> goto assignment
" let g:jedi#usages_command = "<leader>n" -> goto usages
" let g:jedi#rename_command = "<leader>r" -> rename in-scope
" let g:jedi#completions_command = "<" -space> -> autocomplete popup
" let g:jedi#documentation_command = "K" -> see docs of word under cursor
" OVERRIDES
let g:jedi#documentation_command = "<C-k>"


"Remap space to leader
nnoremap <SPACE> <Nop>
nnoremap <SPACE> :wa<CR>
let mapleader=" "
  
set noerrorbells
set ruler
set number relativenumber
set mouse=a
set autoindent
set shiftround
set smarttab
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set scrolloff=8
set wrap
set hidden
set wildmenu
set wildmode=longest,list:longest
set laststatus=2
set title
set backspace=indent,eol,start
set history=1000
set background=dark
set breakindent
set linebreak
set splitbelow
set splitright
set foldmethod=indent
set foldlevelstart=6
set smartcase
set noswapfile
set nobackup
set undofile
set undodir=~/.vim/undodir
set incsearch
set colorcolumn=120
" Puts two spaces before a wrapped line
let &showbreak="  "

syntax on
filetype plugin indent on

set hlsearch
" Clears search highlighting and resets last command
nnoremap <CR> :noh<CR>:<backspace>

" Setup cursor appearance
" Toggle cursor position highlighting
" colorscheme slate 
hi CursorLine cterm=NONE ctermbg=67 ctermfg=white
"guibg=darkred guifg=white
noremap <leader>f :set cursorline! cursorcolumn!<CR>

" Start new line at bottom of file
map <leader>g Go

" Move window with space and directions
noremap <leader>l <C-w>l
noremap <leader>k <C-w>k
noremap <leader>j <C-w>j
noremap <leader>h <C-w>h

" Easier movement
noremap K {
noremap J }
noremap H ^
noremap L $

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
noremap <leader>s :wa<cr>
noremap <leader>W :wqa<cr>

" Indent using TAB and S-TAB
nnoremap <TAB> >>
nnoremap <S-TAB> <<
vnoremap <TAB> >><ESC>gv
vnoremap <S-TAB> <<<ESC>gv

" quit file easily
nnoremap <leader>q :q<cr>

nnoremap <leader>v <c-v>
nnoremap <C-#> <esc>I# <esc>j

" leader commands
nnoremap <leader>; :Limelight!!<cr>
" Run macros with Q
" nnoremap Q @q

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
nnoremap <leader>e <esc>:w<CR>:!clear;python3 %<CR>

" Better undo breakpoints
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
inoremap <CR> <CR><c-g>u

" Rename inline
" jedi vim provides the same functionality with the same key command
" Also maintains scope which this naive find/replace does not
" nnoremap <leader>r "zyiw:%s/<C-R>z//gc<Left><Left><Left>

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

