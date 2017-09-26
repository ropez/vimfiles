" .vimrc

set nocompatible
filetype off

let g:airline_powerline_fonts = 1

" Bundles
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'

" core
Plugin 'kien/ctrlp.vim'
Plugin 'bruno-/vim-husk'
Plugin 'SirVer/ultisnips'
Plugin 'bling/vim-airline'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'edkolev/tmuxline.vim'
" Plugin 'airblade/vim-rooter'

" colors
Plugin 'tomasr/molokai'

" utitilities
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-capslock'
Plugin 'tpope/vim-commentary.git'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-repeat.git'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired.git'
Plugin 'airblade/vim-gitgutter'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'rking/ag.vim'
Plugin 'vim-scripts/winresizer.vim'
Plugin 'qpkorr/vim-renamer'
Plugin 'AndrewRadev/sideways.vim'

" language support
Plugin 'klen/python-mode'
Plugin 'othree/html5.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mtscout6/vim-cjsx'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'groenewege/vim-less'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'tpope/vim-markdown'
Plugin 'jtratner/vim-flavored-markdown'
Plugin 'vim-syntastic/syntastic'

" Plugin 'hsanson/vim-android'
" Plugin 'artur-shaik/vim-javacomplete2'

" The basics
set nobackup
set nowritebackup
set showcmd
set lazyredraw
set title
set wildmenu
set wildmode=longest,list,full
set cursorline
set virtualedit=block

noremap <C-w>s :rightbelow split<cr>
noremap <C-w>v :rightbelow vsplit<cr>

" Hide, read and save files whenever needed, I don't care
set hidden
set autoread
set autowrite

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Paste tmux buffer
nmap ,tp :r!tmux save-buffer -<cr>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,trail:·
"eol:¬

" Show last line
set display+=lastline

" Diff side-by-side
set diffopt+=vertical

" Hidden files
set wildignore+=*.pyc,*.egg-info/*

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
" set scrolloff=3
" nnoremap <C-e> 3<C-e>
" nnoremap <C-y> 3<C-y>

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  set t_Co=256
  colorscheme molokai
  hi Normal ctermbg=none
endif
if has("gui_running")
  set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 13
  colorscheme zellner
endif

" Quick toggle mappings
nmap ,<cr> :nohlsearch<cr>

" Global default whitespace
set ts=4 sts=4 sw=4 expandtab

" Automatic settings for different filetypes
if has("autocmd")
  filetype plugin indent on

  autocmd FileType vim setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType html,xhtml,php setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType debcontrol setlocal ts=2 sts=2 sw=2 et
  autocmd FileType coffee setlocal ts=2 sts=2 sw=2

  autocmd BufRead,BufNewFile *.kv set filetype=yaml
  autocmd BufRead,BufNewFile *.rst set filetype=rest
  autocmd BufRead,BufNewFile *.upstart set filetype=upstart
  autocmd BufRead,BufNewFile *.service,*.target,*.timer set filetype=systemd
  autocmd BufRead,BufNewFile SConstruct set filetype=python
  autocmd FileType rest setlocal tw=80 formatoptions+=t
  autocmd FileType python setlocal tw=99

  autocmd BufRead,BufNewFile wiki.*.txt set filetype=mediawiki
  autocmd BufRead,BufNewFile *wiki.*.tmp set filetype=mediawiki

  " Auto source .vimrc
  autocmd BufWritePost .vimrc source $MYVIMRC

  " au FileType javascript setlocal foldmethod=syntax foldcolumn=3
  au FileType gitcommit setlocal foldmethod=manual spell
  au FileType gitcommit command! Pivotal :r!~/.githooks/prepare-commit-msg
  au FileType gitcommit command! PivotalForce :r!~/.githooks/prepare-commit-msg -u

  au FileType cmake setlocal commentstring=#\ %s

  " :make runs the closure linter
  " au FileType javascript setlocal makeprg=gjslint\ --custom_jsdoc_tags\ property\ % errorformat=%-P%>-----\ FILE\ \ :\ \ %f\ -----,Line\ %l\\,\ %t:%n:\ %m,%-Q
  " au FileType javascript vmap ,gl :!fixjsstylepipe<cr>
  " au FileType javascript nmap ,gl :.!fixjsstylepipe<cr>
endif

highlight link htmlLink Title

" Switch between the last two files
nnoremap ,, <c-^>

" Quick close
nmap ,d :bd<cr>

" Edit or view files in same directory as current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map ,e :edit %%
map ,v :view %%

" test-pipe
command! -nargs=1 RunSilent :exec "silent !<args>" | :redraw!
command! -nargs=1 TestPipe :exe "silent !echo <args> > test-pipe" | :redraw!

" Sudo write
if executable('sudo') && executable('tee')
  command! Swrite
        \ execute 'w !sudo tee % > /dev/null' |
        \ setlocal nomodified
endif

" Map ,c to edit .vimrc
nmap ,c :split $MYVIMRC<cr>

nnoremap gb :SidewaysRight<cr>
nnoremap gB :SidewaysLeft<cr>

" Git mappings
nmap ,gg :Ggrep 
vmap ,gg y:Ggrep 0
map ,gc :Gcommit<cr>
map ,gm :Gcommit --amend<cr>
map ,gb :Gblame<cr>
map ,ga :Git add -p<cr>
map ,gr :Git ra<cr>
map ,gs :Git show -C<cr>
map ,gd :Git diff --cached -C<cr>
map ,gl :Git l<cr>
map ,gr :Git r<cr>
map ,gt :Git st<cr>
map ,gq :Git qq<cr>

" Tags, tags, tags
nmap <C-h> :CtrlPTag<cr>
nmap g<C-p> :CtrlP 
" let g:ctrlp_cmd = 'CtrlPCurWD'

" Map ,/ to grep for last search
map ,/ :Ggrep '/'

" Python coverage
map ,pc :Coveragepy report<cr>

" Virtualenv settings
if filereadable(expand('$VIRTUAL_ENV/.vimrc'))
  source $VIRTUAL_ENV/.vimrc
end

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = '/bin/true'
let g:syntastic_javascript_eslint_exe = './node_modules/.bin/eslint'

" Ignore 'line too long', 'do not assign lambda'
let g:pymode_lint_ignore = "E501,E731,C901"
let g:pymode_rope_guess_project = 0
let g:pymode_rope_complete_on_dot = 0

" It's always bash
let g:is_bash = 1

let g:rehash256 = 1

" Extra settings
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
