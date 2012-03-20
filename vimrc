" .vimrc

call pathogen#infect()

set hidden
nnoremap ' `
nnoremap ` '

map ,l :set cursorline!<cr>

set showcmd
set lazyredraw
set laststatus=2

let mapleader = ","

set history=1000

runtime macros/matchit.vim

set wildmenu

set title

set scrolloff=3

set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

set backspace=indent,eol,start

syntax on
filetype on
filetype plugin on
filetype indent on

set hlsearch
set incsearch

nmap ,<cr> :nohlsearch<cr>

set expandtab
set sw=4
set ts=4 sts=4

set t_Co=256
colorscheme desert256

set autowrite

" Automatic settings for different filetypes
if has("autocmd")
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType html,xhtml,php setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType rst setlocal tw=80 formatoptions+=t

    autocmd BufNewFile,BufNew *.rst setfiletype rest

    autocmd BufRead,BufNewFile wiki.*.txt set filetype=mediawiki

    autocmd BufWritePost .vimrc source $MYVIMRC

    au FileType javascript setlocal foldmethod=syntax foldcolumn=3

    " :make runs the closure linter
    au FileType javascript setlocal makeprg=gjslint\ --custom_jsdoc_tags\ property\ % errorformat=%-P%>-----\ FILE\ \ :\ \ %f\ -----,Line\ %l\\,\ %t:%n:\ %m,%-Q
    au FileType javascript vmap ,gl :!fixjsstylepipe<cr>
    au FileType javascript nmap ,gl :.!fixjsstylepipe<cr>
endif

" Edit or view files in same directory as current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

" Map ,c to edit .vimrc
nmap <leader>c :split $MYVIMRC<cr>

" Open files with <leader>f
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
" Open files, limited to the directory of the current file, with <leader>gf
" This requires the %% mapping found below.
map <leader>gf :CommandTFlush<cr>\|:CommandT %%<cr>

set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=10
set winminheight=10
set winheight=999

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Sudo write
if executable('sudo') && executable('tee')
  command! Swrite
        \ execute 'w !sudo tee % > /dev/null' |
        \ setlocal nomodified
endif

if filereadable('~/.vimrc.local')
    source ~/.vimrc.local
endif

set guioptions=ac

" Git mappings
"
nmap ,gg viwy:Ggrep 0
vmap ,gg y:Ggrep 0
