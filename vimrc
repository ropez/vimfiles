" .vimrc

" Bundles
call pathogen#infect()

" The basics
set nocompatible
set backspace=indent,eol,start
set nobackup
set history=1000
set ruler
set showcmd
set lazyredraw
set laststatus=2
set incsearch
set title
set wildmenu

" Hide, read and save files whenever needed, I don't care
set hidden
set autoread
set autowrite

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,trail:·
"eol:¬

" Show last line
set display+=lastline

" Hide menu and toolbar in gvim
set guioptions=ac
set guicursor=a:blinkoff0
set vb t_vb=

" Switch 0 and ^
noremap 0 ^
noremap ^ 0

" Centralized temp files
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Persistent undo
if has("persistent_undo")
  set undofile
  set undodir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
endif

" Match more stuff
runtime macros/matchit.vim

" Scrolling
set scrolloff=3
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  set t_Co=256
  colorscheme jellybeans
endif

" Quick toggle mappings
nmap ,l :set cursorline!<cr>
nmap ,n :set list!<cr>
nmap ,<cr> :nohlsearch<cr>

" Global default whitespace
set ts=4 sts=4 sw=4 expandtab

" Automatic settings for different filetypes
if has("autocmd")
  filetype plugin indent on

  autocmd FileType vim setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType html,xhtml,php setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab

  autocmd BufRead,BufNewFile *.rst set filetype=rest
  autocmd FileType rest setlocal tw=80 formatoptions+=t

  autocmd BufRead,BufNewFile wiki.*.txt set filetype=mediawiki

  " Auto source .vimrc
  autocmd BufWritePost .vimrc source $MYVIMRC

  au FileType javascript setlocal foldmethod=syntax foldcolumn=3
  au FileType gitcommit setlocal foldmethod=manual

  au FileType cmake setlocal commentstring=#\ %s

  " :make runs the closure linter
  " au FileType javascript setlocal makeprg=gjslint\ --custom_jsdoc_tags\ property\ % errorformat=%-P%>-----\ FILE\ \ :\ \ %f\ -----,Line\ %l\\,\ %t:%n:\ %m,%-Q
  au FileType javascript vmap ,gl :!fixjsstylepipe<cr>
  au FileType javascript nmap ,gl :.!fixjsstylepipe<cr>
endif

" Switch between the last two files
nnoremap ,, <c-^>

" Quick close
nmap ,d :bd<cr>

" Edit or view files in same directory as current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map ,e :edit %%
map ,v :view %%

if 1 " CommandT mappings
  " Flush cache
  map ,tf :CommandTFlush<cr>
  " Open files in the current working directory
  map ,tt :CommandT<cr>
  " Open files in the directory of the current file
  map ,tg :CommandT %:h<cr>
  " Switch to buffer
  map ,tb :CommandTBuffer<cr>
endif

" Sudo write
if executable('sudo') && executable('tee')
  command! Swrite
        \ execute 'w !sudo tee % > /dev/null' |
        \ setlocal nomodified
endif

" Map ,c to edit .vimrc
nmap ,c :split $MYVIMRC<cr>

" Git mappings
nmap ,gg viwy:Ggrep 0
vmap ,gg y:Ggrep 0

" Map ,/ to grep for last search
map ,/ :Ggrep '/'

" Extra settings
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
