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
set shiftwidth=4
set tabstop=4
set softtabstop=4
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
set foldlevelstart=0
" Puts two spaces before a wrapped line
let &showbreak="  "

syntax on
filetype off
filetype plugin indent on

set hlsearch
" Clears search highlighting and resets last command
nnoremap <CR> :noh<CR>:<backspace>

" Setup cursor appearance
" Toggle cursor position highlighting
colorscheme slate 
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
inoremap <> <><LEFT>
inoremap () ()<LEFT>
inoremap {} {}<LEFT>
inoremap [] []<LEFT>
inoremap "" ""<LEFT>
inoremap """ """<CR>"""<UP>
inoremap '' ''<LEFT>
inoremap `` ``<LEFT>

" Save files quicker
noremap <leader>s :wa<cr>

" Indent using TAB and S-TAB
nnoremap <TAB> >>
nnoremap <S-TAB> <<
vnoremap <TAB> >><ESC>gv
vnoremap <S-TAB> <<<ESC>gv

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
" 
set path+=**
let g:netrw_banner = 0        " disable annoying banner
let g:netrw_browse_split = 4  " open in prior window
let g:netrw_altv = 1          " open splits to the right
let g:netrw_liststyle = 3     " tree view
let g:netrw_winsize = 10      " Opens as side explorer
" let g:netrw_list_hide=netrw_gitignore#Hide()
" let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
augroup ProjectDrawer
  autocmd!
    autocmd VimEnter * :Vexplore
augroup END
" inoremap def( def ():<CR>"""Return: """<ESC>kF(i

" SNIPPETS
" PYTHON
nnoremap <leader>r <esc>:w<CR>:!clear;python3 %<CR>


